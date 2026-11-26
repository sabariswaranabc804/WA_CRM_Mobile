import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/formatters.dart';
import '../../models/campaign.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';

/// Campaign stats plus the lifecycle actions the API allows.
/// Pops `true` when an action changed the campaign.
class CampaignDetailSheet extends StatefulWidget {
  final Campaign campaign;

  const CampaignDetailSheet({super.key, required this.campaign});

  @override
  State<CampaignDetailSheet> createState() => _CampaignDetailSheetState();
}

class _CampaignDetailSheetState extends State<CampaignDetailSheet> {
  late Campaign _campaign;
  bool _busy = false;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    _campaign = widget.campaign;
    _refreshStats();
  }

  Future<void> _refreshStats() async {
    try {
      final fresh =
          await context.read<AppServices>().campaigns.stats(_campaign.id);
      if (!mounted) return;
      setState(() => _campaign = fresh);
    } on ApiException {
      // The sheet already shows the list's copy; a failed refresh is harmless.
    }
  }

  Future<void> _run(Future<void> Function() action, String successMessage) async {
    setState(() => _busy = true);
    try {
      await action();
      _changed = true;
      await _refreshStats();
      if (mounted) showAppSnack(context, successMessage);
    } on ApiException catch (e) {
      if (mounted) showAppSnack(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final campaigns = context.read<AppServices>().campaigns;
    final status = _campaign.status;

    final canLaunch = status == 'draft' || status == 'scheduled';
    final canPause = status == 'sending' || status == 'queued';
    final canCancel =
        status != 'completed' && status != 'cancelled' && status != 'failed';

    return AppDraggableSheet(
      initialSize: 0.65,
      changed: () => _changed,
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
                  _campaign.name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AppBadge.status(status),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              AppStatTile(
                label: 'Sent',
                value: _campaign.sentCount,
                color: AppColors.info,
              ),
              AppStatTile(
                label: 'Delivered',
                value: _campaign.deliveredCount,
                color: AppColors.success,
              ),
              AppStatTile(
                label: 'Failed',
                value: _campaign.failedCount,
                color: AppColors.danger,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const Divider(),
          AppDetailRow(label: 'Channel', value: _campaign.channel),
          AppDetailRow(
            label: 'Recipients',
            value: '${_campaign.totalRecipients}',
          ),
          AppDetailRow(
            label: 'Scheduled',
            value: fullDateTime(_campaign.scheduledAt),
          ),
          AppDetailRow(
            label: 'Started',
            value: fullDateTime(_campaign.startedAt),
          ),
          AppDetailRow(
            label: 'Completed',
            value: fullDateTime(_campaign.completedAt),
          ),
          const Divider(),
          const SizedBox(height: AppSpacing.lg),
          if (canLaunch)
            _action(
              label: 'Launch campaign',
              icon: Icons.play_arrow_rounded,
              onPressed: () => _run(
                () => campaigns.launch(_campaign.id),
                'Campaign launched',
              ),
            ),
          if (canPause)
            _action(
              label: 'Pause campaign',
              icon: Icons.pause_rounded,
              onPressed: () => _run(
                () => campaigns.pause(_campaign.id),
                'Campaign paused',
              ),
            ),
          if (canCancel)
            _action(
              label: 'Cancel campaign',
              icon: Icons.stop_rounded,
              variant: AppButtonVariant.dangerOutline,
              onPressed: () => _run(
                () => campaigns.cancel(_campaign.id),
                'Campaign cancelled',
              ),
            ),
        ],
      ),
    );
  }

  Widget _action({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    AppButtonVariant variant = AppButtonVariant.primary,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppButton(
        label: label,
        icon: icon,
        variant: variant,
        fullWidth: true,
        onPressed: _busy ? null : onPressed,
      ),
    );
  }
}
