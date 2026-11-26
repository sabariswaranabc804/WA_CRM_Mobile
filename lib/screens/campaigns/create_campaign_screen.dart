import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/formatters.dart';
import '../../models/channel_account.dart';
import '../../models/contact_list.dart';
import '../../models/template.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';

/// Compose a WhatsApp campaign.
///
/// `POST /campaigns` needs four ids plus an optional time, so this screen
/// loads the three pickers up front and only enables Create once every choice
/// is made. Scheduling is the one optional setting: leave it off and the
/// server files the campaign as a `draft` to launch by hand; set a time and it
/// becomes `scheduled`.
class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({super.key});

  @override
  State<CreateCampaignScreen> createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();

  List<MessageTemplate> _templates = [];
  List<ContactList> _lists = [];
  List<ChannelAccount> _senders = [];

  MessageTemplate? _template;
  ContactList? _list;
  ChannelAccount? _sender;
  DateTime? _scheduledAt;

  /// One controller per `{{n}}` in the chosen template, rebuilt whenever the
  /// template changes.
  List<TextEditingController> _variableFields = [];

  bool _loading = true;
  bool _saving = false;
  String? _error;

  /// Set when the agent lacks CHANNEL_MANAGE, which hides the sender list.
  bool _sendersForbidden = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _name.dispose();
    _disposeVariableFields();
    super.dispose();
  }

  void _disposeVariableFields() {
    for (final controller in _variableFields) {
      controller.dispose();
    }
  }

  /// Rebuilds the value inputs for [template], prefilled with the samples the
  /// template was submitted to Meta with.
  void _rebuildVariableFields(MessageTemplate template) {
    _disposeVariableFields();
    _variableFields = List.generate(
      template.placeholderCount,
      (i) => TextEditingController(text: template.sampleFor(i) ?? ''),
    );
  }

  List<String> get _variableValues =>
      _variableFields.map((c) => c.text.trim()).toList();

  bool get _variablesComplete =>
      _variableValues.every((value) => value.isNotEmpty);

  /// The values step only exists for templates with placeholders, so the steps
  /// after it shift by one.
  int _stepNumber(int base) {
    final hasValuesStep = (_template?.placeholderCount ?? 0) > 0;
    return hasValuesStep ? base : base - 1;
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final services = context.read<AppServices>();
    try {
      // Only approved templates can be broadcast, and only a connected sender
      // can carry them.
      final templates = await services.templates.approved();
      final lists = await services.contacts.lists();

      var senders = <ChannelAccount>[];
      var forbidden = false;
      try {
        senders = await services.channels.whatsappSenders();
      } on ApiException catch (e) {
        // Listing senders needs CHANNEL_MANAGE; without it the campaign
        // cannot be composed here, but that is worth saying plainly.
        if (e.statusCode == 403) {
          forbidden = true;
        } else {
          rethrow;
        }
      }

      if (!mounted) return;
      setState(() {
        _templates = templates;
        _lists = lists;
        _senders = senders;
        _sendersForbidden = forbidden;
        // With a single sender there is no choice to make.
        _sender = senders.length == 1 ? senders.first : null;
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

  bool get _canSubmit =>
      _template != null &&
      _list != null &&
      _sender != null &&
      _variablesComplete &&
      !_saving;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || !_canSubmit) return;

    setState(() => _saving = true);
    try {
      final campaign = await context.read<AppServices>().campaigns.create(
            name: _name.text,
            channelAccountId: _sender!.id,
            templateId: _template!.id,
            contactListId: _list!.id,
            scheduledAt: _scheduledAt,
            templateVariables: _variableValues,
          );

      if (!mounted) return;
      Navigator.pop(context, true);
      showAppSnack(
        context,
        _scheduledAt == null
            ? 'Draft "${campaign.name}" created'
            : 'Campaign scheduled for ${fullDateTime(_scheduledAt)}',
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnack(context, e.message, isError: true);
    }
  }

  Future<void> _pickSchedule() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt ?? now.add(const Duration(hours: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        _scheduledAt ?? now.add(const Duration(hours: 1)),
      ),
    );
    if (time == null || !mounted) return;

    final chosen = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (chosen.isBefore(DateTime.now())) {
      showAppSnack(context, 'Pick a time in the future', isError: true);
      return;
    }
    setState(() => _scheduledAt = chosen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New campaign')),
      body: _body(),
      bottomNavigationBar: _loading || _error != null ? null : _submitBar(),
    );
  }

  Widget _body() {
    if (_loading) return const AppLoader();
    if (_error != null) return AppErrorState(message: _error!, onRetry: _load);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        children: [
          AppInput(
            controller: _name,
            label: 'Campaign name',
            hint: 'Diwali offer — VIP customers',
            prefixIcon: Icons.campaign_outlined,
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Give the campaign a name' : null,
          ),
          const SizedBox(height: AppSpacing.xl),

          _StepLabel(index: 1, label: 'Message'),
          _PickerTile(
            icon: Icons.description_outlined,
            title: _template?.name ?? 'Choose a template',
            subtitle: _template == null
                ? 'Only Meta-approved templates can be broadcast'
                : _template!.body,
            chosen: _template != null,
            onTap: _templates.isEmpty ? null : _pickTemplate,
          ),
          if (_templates.isEmpty)
            const _InlineHint(
              message: 'No approved templates yet. Submit one from the '
                  'Templates tab and wait for Meta to approve it.',
            ),
          if (_template != null && _template!.placeholderCount == 0)
            _TemplatePreview(template: _template!, values: const []),

          // Only templates with {{n}} placeholders get a values step, so a
          // plain template's form stays three choices long.
          if (_template != null && _template!.placeholderCount > 0) ...[
            const SizedBox(height: AppSpacing.xl),
            _StepLabel(index: 2, label: 'Message values'),
            _VariableFields(
              template: _template!,
              controllers: _variableFields,
              // Repaint the preview and re-evaluate the submit button.
              onChanged: () => setState(() {}),
            ),
            _TemplatePreview(template: _template!, values: _variableValues),
          ],

          const SizedBox(height: AppSpacing.xl),
          _StepLabel(index: _stepNumber(2), label: 'Audience'),
          _PickerTile(
            icon: Icons.groups_outlined,
            title: _list?.name ?? 'Choose a contact list',
            subtitle: _list == null
                ? 'Who this campaign goes to'
                : (_list!.isDynamic
                    ? 'Dynamic list — rebuilt at send time'
                    : 'Static list'),
            chosen: _list != null,
            onTap: _lists.isEmpty ? null : _pickList,
          ),
          if (_lists.isEmpty)
            const _InlineHint(
              message: 'No contact lists yet. Create one in the web app.',
            ),

          const SizedBox(height: AppSpacing.xl),
          _StepLabel(index: _stepNumber(3), label: 'Send from'),
          _PickerTile(
            icon: Icons.smartphone_outlined,
            title: _sender?.label ?? 'Choose a WhatsApp number',
            subtitle: _sender?.subtitle ?? 'The number recipients will see',
            chosen: _sender != null,
            onTap: _senders.length < 2 ? null : _pickSender,
          ),
          if (_sendersForbidden)
            const _InlineHint(
              message: 'You do not have permission to view sending numbers. '
                  'Ask an admin for the Channel Manage permission.',
            )
          else if (_senders.isEmpty)
            const _InlineHint(
              message: 'No connected WhatsApp number. Connect one in the web '
                  'app first.',
            ),

          const SizedBox(height: AppSpacing.xl),
          _StepLabel(index: _stepNumber(4), label: 'Schedule', optional: true),
          _ScheduleControl(
            scheduledAt: _scheduledAt,
            onPick: _pickSchedule,
            onClear: () => setState(() => _scheduledAt = null),
          ),
        ],
      ),
    );
  }

  Widget _submitBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          border: Border(top: Divider.createBorderSide(context)),
        ),
        child: AppButton(
          label: _scheduledAt == null ? 'Create draft' : 'Schedule campaign',
          icon: _scheduledAt == null
              ? Icons.save_outlined
              : Icons.schedule_send_outlined,
          size: AppButtonSize.lg,
          fullWidth: true,
          isLoading: _saving,
          loadingLabel: 'Creating…',
          onPressed: _canSubmit ? _submit : null,
        ),
      ),
    );
  }

  // ── Pickers ──────────────────────────────────────────────────────────

  Future<void> _pickTemplate() async {
    final picked = await _showPicker<MessageTemplate>(
      title: 'Choose a template',
      items: _templates,
      isSelected: (t) => t.id == _template?.id,
      titleOf: (t) => t.name,
      subtitleOf: (t) => t.body,
      trailingOf: (t) => t.language,
    );
    if (picked == null) return;
    setState(() {
      _template = picked;
      _rebuildVariableFields(picked);
    });
  }

  Future<void> _pickList() async {
    final picked = await _showPicker<ContactList>(
      title: 'Choose an audience',
      items: _lists,
      isSelected: (l) => l.id == _list?.id,
      titleOf: (l) => l.name,
      subtitleOf: (l) => l.isDynamic ? 'Dynamic list' : 'Static list',
    );
    if (picked != null) setState(() => _list = picked);
  }

  Future<void> _pickSender() async {
    final picked = await _showPicker<ChannelAccount>(
      title: 'Send from',
      items: _senders,
      isSelected: (s) => s.id == _sender?.id,
      titleOf: (s) => s.label,
      subtitleOf: (s) => s.subtitle,
    );
    if (picked != null) setState(() => _sender = picked);
  }

  /// One bottom-sheet picker for all three choices.
  Future<T?> _showPicker<T>({
    required String title,
    required List<T> items,
    required bool Function(T) isSelected,
    required String Function(T) titleOf,
    required String Function(T) subtitleOf,
    String Function(T)? trailingOf,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      builder: (_) => AppDraggableSheet(
        title: title,
        initialSize: 0.6,
        builder: (context, controller) => ListView.separated(
          controller: controller,
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          itemCount: items.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final item = items[i];
            final selected = isSelected(item);

            return ListTile(
              onTap: () => Navigator.pop(context, item),
              leading: Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? AppColors.accent(context) : null,
              ),
              title: Text(
                titleOf(item),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                subtitleOf(item),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: trailingOf == null
                  ? null
                  : Text(
                      trailingOf(item),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
            );
          },
        ),
      ),
    );
  }
}

/// Numbered section heading, so the form reads as a sequence of choices.
class _StepLabel extends StatelessWidget {
  final int index;
  final String label;
  final bool optional;

  const _StepLabel({
    required this.index,
    required this.label,
    this.optional = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accent(context).withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: AppColors.accent(context),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          if (optional) ...[
            const SizedBox(width: AppSpacing.sm),
            Text('Optional', style: Theme.of(context).textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
}

/// A tappable row standing in for a select control.
class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool chosen;
  final VoidCallback? onTap;

  const _PickerTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.chosen,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);
    final disabled = onTap == null;

    return Opacity(
      opacity: disabled ? 0.55 : 1,
      child: AppCard(
        onTap: onTap,
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: (chosen ? accent : AppColors.neutral)
                    .withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                icon,
                size: 20,
                color: chosen ? accent : AppColors.subtitle(context),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: chosen ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              chosen ? Icons.check_circle : Icons.chevron_right,
              size: chosen ? 20 : 22,
              color: chosen ? accent : AppColors.subtitle(context),
            ),
          ],
        ),
      ),
    );
  }
}

/// Send-now versus send-later, the form's only optional setting.
class _ScheduleControl extends StatelessWidget {
  final DateTime? scheduledAt;
  final VoidCallback onPick;
  final VoidCallback onClear;

  const _ScheduleControl({
    required this.scheduledAt,
    required this.onPick,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final scheduled = scheduledAt != null;

    return AppCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          SwitchListTile(
            value: scheduled,
            onChanged: (on) => on ? onPick() : onClear(),
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Schedule for later',
              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              scheduled
                  ? 'Sends automatically at the time below'
                  : 'Saved as a draft you launch by hand',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          if (scheduled) ...[
            const Divider(height: AppSpacing.lg),
            InkWell(
              onTap: onPick,
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    Icon(
                      Icons.event_outlined,
                      size: 19,
                      color: AppColors.accent(context),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        fullDateTime(scheduledAt),
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// One input per `{{n}}` in the template body.
///
/// Every recipient gets the same text, which is worth stating plainly — a
/// coupon code typed here is not unique per customer.
class _VariableFields extends StatelessWidget {
  final MessageTemplate template;
  final List<TextEditingController> controllers;
  final VoidCallback onChanged;

  const _VariableFields({
    required this.template,
    required this.controllers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < controllers.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AppInput(
              controller: controllers[i],
              label: template.labelFor(i),
              hint: template.sampleFor(i),
              prefixIcon: Icons.data_object,
              onChanged: (_) => onChanged(),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Meta rejects the send if this is empty'
                  : null,
            ),
          ),
        const AppNotice(
          icon: Icons.groups_outlined,
          message: 'These values are the same for every recipient. '
              'Per-contact values are not supported yet.',
        ),
      ],
    );
  }
}

/// A WhatsApp-shaped preview of the chosen template, with [values] substituted
/// so the agent sees the message as the customer will.
class _TemplatePreview extends StatelessWidget {
  final MessageTemplate template;
  final List<String> values;

  const _TemplatePreview({required this.template, required this.values});

  @override
  Widget build(BuildContext context) {
    final bodyColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
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
                if (template.headerText != null) ...[
                  Text(
                    template.headerText!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: bodyColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                ],
                Text(
                  template.preview(values),
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
                    style: TextStyle(
                      fontSize: 11,
                      color: bodyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Explains why a picker above it is unavailable.
class _InlineHint extends StatelessWidget {
  final String message;

  const _InlineHint({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: AppNotice(
        icon: Icons.info_outline,
        iconColor: AppColors.warning,
        message: message,
      ),
    );
  }
}
