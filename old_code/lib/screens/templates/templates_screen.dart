import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../models/template.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';
import 'template_detail_sheet.dart';

/// The Templates tab: browse the catalogue and track Meta's review status.
///
/// Authoring a template (header media, buttons, variable samples) is a
/// desktop-sized job and stays on the web client. From here a tenant can
/// review, submit for approval and import what already exists on the WABA.
class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  static const _statuses = ['all', 'approved', 'pending', 'draft', 'rejected'];

  List<MessageTemplate> _templates = [];
  String _status = 'all';
  bool _loading = true;
  bool _syncing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final templates =
          await context.read<AppServices>().templates.list(status: _status);
      if (!mounted) return;
      setState(() {
        _templates = templates;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _loading = false;
      });
    }
  }

  void _setStatus(String status) {
    if (_status == status) return;
    setState(() => _status = status);
    _load();
  }

  Future<void> _sync() async {
    setState(() => _syncing = true);
    try {
      final result = await context.read<AppServices>().templates.syncAll();
      if (!mounted) return;
      final imported = result['imported'] ?? 0;
      final updated = result['updated'] ?? 0;
      showAppSnack(context, 'Imported $imported, updated $updated');
      await _load();
    } on ApiException catch (e) {
      if (mounted) showAppSnack(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  Future<void> _openDetail(MessageTemplate template) async {
    final changed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => TemplateDetailSheet(template: template),
    );
    if (changed == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates'),
        actions: [AppRefreshAction(onPressed: _load)],
      ),
      body: Column(
        children: [
          AppFilterBar(
            options: _statuses,
            selected: _status,
            onSelected: _setStatus,
          ),
          Expanded(
            child: AppAsyncListView<MessageTemplate>(
              isLoading: _loading,
              error: _error,
              items: _templates,
              onRetry: _load,
              onRefresh: _load,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                90, // Clears the extended FAB.
              ),
              emptyState: AppEmptyState(
                icon: Icons.description_outlined,
                title: _status == 'all'
                    ? 'No templates yet'
                    : 'No $_status templates',
                message: 'Create templates in the web app, or import the ones '
                    'already approved on your WhatsApp account.',
              ),
              itemBuilder: (context, template, _) => TemplateCard(
                template: template,
                onTap: () => _openDetail(template),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _syncing ? null : _sync,
        icon: _syncing
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : const Icon(Icons.cloud_download_outlined),
        label: Text(_syncing ? 'Importing…' : 'Import from Meta'),
      ),
    );
  }
}

/// Template card with a WhatsApp-bubble preview of the body.
class TemplateCard extends StatelessWidget {
  final MessageTemplate template;
  final VoidCallback onTap;

  const TemplateCard({super.key, required this.template, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bodyColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  template.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppBadge.status(template.status),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${template.category ?? 'UNCATEGORISED'} · ${template.language}',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 0.3,
              color: AppColors.subtitle(context),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppBubble(
            padding: const EdgeInsets.all(AppSpacing.sm + 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (template.headerText != null) ...[
                  Text(
                    template.headerText!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: bodyColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                ],
                Text(
                  template.body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.35,
                    color: bodyColor,
                  ),
                ),
                if (template.footerText != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    template.footerText!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    // Muted against the bubble, not the page.
                    style: TextStyle(
                      fontSize: 11,
                      color: bodyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (template.buttons.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs + 2,
              runSpacing: AppSpacing.xs + 2,
              children: template.buttons
                  .map((b) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm + 2,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.tick.withValues(alpha: 0.5),
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          b.text,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.tick,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
