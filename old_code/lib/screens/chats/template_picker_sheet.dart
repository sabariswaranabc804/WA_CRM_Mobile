import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../models/template.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';

/// Picks an approved template to send, and pops its id.
///
/// Templates carrying `{{n}}` placeholders are listed but not selectable:
/// `send-reply.use-case.js` posts an empty `components` array, so Meta rejects
/// any template that expects variable values. Offering them would only produce
/// a failed send.
class TemplatePickerSheet extends StatefulWidget {
  const TemplatePickerSheet({super.key});

  @override
  State<TemplatePickerSheet> createState() => _TemplatePickerSheetState();
}

class _TemplatePickerSheetState extends State<TemplatePickerSheet> {
  List<MessageTemplate> _templates = [];
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
      final templates = await context.read<AppServices>().templates.approved();
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

  @override
  Widget build(BuildContext context) {
    return AppDraggableSheet(
      title: 'Choose a template',
      titleIcon: Icons.description_outlined,
      builder: (context, controller) => AppAsyncListView<MessageTemplate>(
        isLoading: _loading,
        error: _error,
        items: _templates,
        controller: controller,
        onRetry: _load,
        separator: const Divider(height: 1),
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        emptyState: const AppEmptyState(
          icon: Icons.description_outlined,
          title: 'No approved templates',
          message: 'Only templates approved by Meta can be sent. Create and '
              'submit one from the Templates tab.',
        ),
        itemBuilder: (context, template, _) => _TemplateOption(template: template),
      ),
    );
  }
}

class _TemplateOption extends StatelessWidget {
  final MessageTemplate template;

  const _TemplateOption({required this.template});

  @override
  Widget build(BuildContext context) {
    final blocked = template.hasVariables;

    return ListTile(
      enabled: !blocked,
      onTap: blocked ? null : () => Navigator.pop(context, template.id),
      title: Text(
        template.name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 3),
          Text(
            template.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, height: 1.3),
          ),
          if (blocked)
            const Padding(
              padding: EdgeInsets.only(top: AppSpacing.xs + 2),
              child: Text(
                'Needs values for its placeholders — usable in a campaign, '
                'not in a reply yet.',
                style: TextStyle(fontSize: 11.5, color: AppColors.warning),
              ),
            ),
        ],
      ),
      trailing: Text(
        template.language,
        style: TextStyle(
          fontSize: 11,
          color: AppColors.subtitle(context),
          fontWeight: FontWeight.w600,
        ),
      ),
      isThreeLine: true,
    );
  }
}
