import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/formatters.dart';
import '../../models/template.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';

/// Full template preview plus the review actions. Pops `true` if anything changed.
class TemplateDetailSheet extends StatefulWidget {
  final MessageTemplate template;

  const TemplateDetailSheet({super.key, required this.template});

  @override
  State<TemplateDetailSheet> createState() => _TemplateDetailSheetState();
}

class _TemplateDetailSheetState extends State<TemplateDetailSheet> {
  late MessageTemplate _template;
  bool _busy = false;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    _template = widget.template;
  }

  Future<void> _reload() async {
    try {
      final fresh =
          await context.read<AppServices>().templates.getById(_template.id);
      if (!mounted) return;
      setState(() => _template = fresh);
    } on ApiException {
      // Keep showing the copy we already have.
    }
  }

  Future<void> _run(Future<void> Function() action, String message) async {
    setState(() => _busy = true);
    try {
      await action();
      _changed = true;
      await _reload();
      if (mounted) showAppSnack(context, message);
    } on ApiException catch (e) {
      if (mounted) showAppSnack(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final templates = context.read<AppServices>().templates;
    final canSubmit =
        _template.status == 'draft' || _template.status == 'rejected';
    final canCheck =
        _template.status == 'pending' || _template.status == 'approved';

    return AppDraggableSheet(
      changed: () => _changed,
      maxSize: 0.94,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.lg,
          AppSpacing.xl,
          AppSpacing.xxl,
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _template.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AppBadge.status(_template.status),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${_template.category ?? 'UNCATEGORISED'} · ${_template.language}'
            ' · updated ${shortDate(_template.updatedAt)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (_template.rejectionReason != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: AppColors.danger.withValues(alpha: 0.35),
                ),
              ),
              child: AppNotice(
                icon: Icons.error_outline,
                iconColor: AppColors.danger,
                message: _template.rejectionReason!,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text('Preview', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          _preview(context),
          if (_template.hasVariables) ...[
            const SizedBox(height: AppSpacing.lg),
            const AppNotice(
              icon: Icons.info_outline,
              iconColor: AppColors.warning,
              message: 'This template has placeholders. Set their values when '
                  'you build a campaign. Inbox replies cannot fill them yet, '
                  'so it is not offered in the reply composer.',
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          if (canSubmit)
            AppButton(
              label: 'Submit for review',
              icon: Icons.send_outlined,
              fullWidth: true,
              isLoading: _busy,
              loadingLabel: 'Submitting…',
              onPressed: () => _run(
                () => templates.submit(_template.id),
                'Submitted to Meta for review',
              ),
            ),
          if (canCheck)
            AppButton(
              label: 'Check review status',
              icon: Icons.sync,
              variant: AppButtonVariant.outline,
              fullWidth: true,
              isLoading: _busy,
              loadingLabel: 'Checking…',
              onPressed: () => _run(
                () => templates.refreshStatus(_template.id),
                'Status is up to date',
              ),
            ),
        ],
      ),
    );
  }

  /// Renders the template the way WhatsApp will, wallpaper included.
  Widget _preview(BuildContext context) {
    final bodyColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.chatBackground(context),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppBubble(
            padding: const EdgeInsets.all(AppSpacing.sm + 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_template.headerType != null &&
                    _template.headerType != 'TEXT')
                  Container(
                    width: double.infinity,
                    height: 90,
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Center(
                      child: Text(
                        '${_template.headerType} header',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: bodyColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                if (_template.headerText != null) ...[
                  Text(
                    _template.headerText!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: bodyColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs + 2),
                ],
                Text(
                  _template.body,
                  style: TextStyle(fontSize: 14, height: 1.4, color: bodyColor),
                ),
                if (_template.footerText != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _template.footerText!,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: bodyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (_template.buttons.isNotEmpty)
            ..._template.buttons.map(
              (b) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: AppSpacing.xs),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  b.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: AppColors.tick,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
