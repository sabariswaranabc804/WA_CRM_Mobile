import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wa_crm_mobile/core/constants/api_endpoints.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/core/network/api_client_provider.dart';
import 'package:wa_crm_mobile/shared/widgets/widgets.dart';

class TemplatePickerSheet extends ConsumerStatefulWidget {
  const TemplatePickerSheet({super.key});

  @override
  ConsumerState<TemplatePickerSheet> createState() => _TemplatePickerSheetState();
}

class _TemplatePickerSheetState extends ConsumerState<TemplatePickerSheet> {
  List<Map<String, dynamic>> _templates = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final client = ref.read(apiClientProvider);
      final response = await client.getApiConnection(url: ApiEndpoints.templates);

      List<dynamic> rawList = [];
      if (response is Map && response['data'] is List) {
        rawList = response['data'] as List<dynamic>;
      } else if (response is List) {
        rawList = response;
      }

      final templates = rawList
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .where((t) => t['status'] == 'APPROVED' || t['status'] == 'approved')
          .toList();

      if (!mounted) return;
      setState(() {
        _templates = templates;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Unable to load WhatsApp templates.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDraggableSheet(
      title: 'Approved Templates',
      titleIcon: Icons.bookmark_added_rounded,
      builder: (context, scrollController) {
        return AppAsyncListView<Map<String, dynamic>>(
          controller: scrollController,
          isLoading: _loading,
          items: _templates,
          error: _error,
          onRetry: _loadTemplates,
          emptyState: const AppEmptyState(
            icon: Icons.bookmark_outline_rounded,
            title: 'No Approved Templates',
            message:
                'Approved WhatsApp Cloud API templates will appear here to start a 24-hour window.',
          ),
          itemBuilder: (context, template, index) {
            final id = int.tryParse(template['id'].toString()) ?? 0;
            final name = template['name']?.toString() ?? 'Template';
            final body = template['body']?.toString() ?? '';
            final category = template['category']?.toString() ?? 'MARKETING';

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    AppBadge(
                      label: category,
                      color: AppColors.secondary,
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.subtitle(context),
                    ),
                  ),
                ),
                trailing:  Icon(
                  Icons.send_rounded,
                  color: AppColors.secondary500,
                  size: 20,
                ),
                onTap: () => Navigator.of(context).pop(id),
              ),
            );
          },
        );
      },
    );
  }
}
