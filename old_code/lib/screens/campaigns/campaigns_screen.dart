import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/formatters.dart';
import '../../models/campaign.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';
import 'campaign_detail_sheet.dart';
import 'create_campaign_screen.dart';

/// The Campaigns tab: compose broadcasts, watch them send, control them.
class CampaignsScreen extends StatefulWidget {
  const CampaignsScreen({super.key});

  @override
  State<CampaignsScreen> createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  static const _statuses = [
    'all',
    'draft',
    'scheduled',
    'sending',
    'completed',
    'failed',
  ];

  List<Campaign> _campaigns = [];
  String _status = 'all';
  bool _loading = true;
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
      final campaigns =
          await context.read<AppServices>().campaigns.list(status: _status);
      if (!mounted) return;
      setState(() {
        _campaigns = campaigns;
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

  Future<void> _openDetail(Campaign campaign) async {
    final changed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => CampaignDetailSheet(campaign: campaign),
    );
    if (changed == true) _load();
  }

  Future<void> _create() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const CreateCampaignScreen()),
    );
    if (created == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaigns'),
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
            child: AppAsyncListView<Campaign>(
              isLoading: _loading,
              error: _error,
              items: _campaigns,
              onRetry: _load,
              onRefresh: _load,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                96, // Clears the FAB.
              ),
              emptyState: AppEmptyState(
                icon: Icons.campaign_outlined,
                title: _status == 'all'
                    ? 'No campaigns yet'
                    : 'No $_status campaigns',
                message: _status == 'all'
                    ? 'Broadcast an approved template to a contact list.'
                    : 'Nothing here right now.',
                action: _status == 'all'
                    ? AppButton(
                        label: 'New campaign',
                        icon: Icons.add,
                        onPressed: _create,
                      )
                    : null,
              ),
              itemBuilder: (context, campaign, i) {
                // A reach summary sits above the list rather than in the app
                // bar, so it scrolls away instead of stealing header space.
                final card = CampaignCard(
                  campaign: campaign,
                  onTap: () => _openDetail(campaign),
                );
                if (i != 0) return card;
                return Column(
                  children: [
                    _ReachSummary(campaigns: _campaigns),
                    const SizedBox(height: AppSpacing.md),
                    card,
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _create,
        icon: const Icon(Icons.add),
        label: const Text('New campaign'),
      ),
    );
  }
}

/// Totals across the campaigns currently in view.
class _ReachSummary extends StatelessWidget {
  final List<Campaign> campaigns;

  const _ReachSummary({required this.campaigns});

  @override
  Widget build(BuildContext context) {
    var sent = 0;
    var delivered = 0;
    var failed = 0;
    for (final c in campaigns) {
      sent += c.sentCount;
      delivered += c.deliveredCount;
      failed += c.failedCount;
    }

    // Nothing has been sent yet — a row of zeroes would be noise.
    if (sent == 0 && delivered == 0 && failed == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient(context),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          _SummaryStat(label: 'Sent', value: sent),
          _SummaryDivider(),
          _SummaryStat(label: 'Delivered', value: delivered),
          _SummaryDivider(),
          _SummaryStat(label: 'Failed', value: failed),
        ],
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final int value;

  const _SummaryStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: Colors.white.withValues(alpha: 0.25),
    );
  }
}

/// One campaign in the list, with its send progress.
class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final VoidCallback onTap;

  const CampaignCard({super.key, required this.campaign, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final progress = campaign.progress;
    final color = statusColor(campaign.status);

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // A status-tinted glyph makes the state readable at a glance,
              // before the badge is even read.
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(_statusIcon(campaign.status), size: 20, color: color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _timingLine(campaign),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppBadge.status(campaign.status),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 7,
                      backgroundColor: color.withValues(alpha: 0.15),
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${(progress * 100).round()}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                AppMetric(
                  label: 'Recipients',
                  value: '${campaign.totalRecipients}',
                ),
                AppMetric(label: 'Sent', value: '${campaign.sentCount}'),
                AppMetric(
                  label: 'Delivered',
                  value: '${campaign.deliveredCount}',
                ),
                AppMetric(
                  label: 'Failed',
                  value: '${campaign.failedCount}',
                  valueColor:
                      campaign.failedCount > 0 ? AppColors.danger : null,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// The most useful date for the campaign's current state.
  static String _timingLine(Campaign campaign) {
    if (campaign.completedAt != null) {
      return 'Completed ${fullDateTime(campaign.completedAt)}';
    }
    if (campaign.startedAt != null) {
      return 'Started ${fullDateTime(campaign.startedAt)}';
    }
    if (campaign.scheduledAt != null) {
      return 'Scheduled ${fullDateTime(campaign.scheduledAt)}';
    }
    return 'Created ${shortDate(campaign.createdAt)}';
  }

  static IconData _statusIcon(String status) => switch (status) {
        'sending' || 'queued' => Icons.send_rounded,
        'scheduled' => Icons.schedule_rounded,
        'completed' => Icons.check_circle_outline_rounded,
        'failed' => Icons.error_outline_rounded,
        'cancelled' => Icons.cancel_outlined,
        'paused' => Icons.pause_circle_outline_rounded,
        _ => Icons.edit_outlined, // draft
      };
}
