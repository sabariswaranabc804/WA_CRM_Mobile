import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../models/contact.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';

/// Create or edit a contact. Pops `true` when something changed.
class ContactFormSheet extends StatefulWidget {
  final Contact? existing;

  const ContactFormSheet({super.key, this.existing});

  @override
  State<ContactFormSheet> createState() => _ContactFormSheetState();
}

class _ContactFormSheetState extends State<ContactFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _tags;

  bool _saving = false;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _name = TextEditingController(text: existing?.fullName ?? '');
    _phone = TextEditingController(text: existing?.phone ?? '');
    _email = TextEditingController(text: existing?.email ?? '');
    _tags = TextEditingController(text: existing?.tags.join(', ') ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _tags.dispose();
    super.dispose();
  }

  List<String> get _parsedTags => _tags.text
      .split(',')
      .map((t) => t.trim())
      .where((t) => t.isNotEmpty)
      .toList();

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final contacts = context.read<AppServices>().contacts;
    try {
      if (_isEdit) {
        await contacts.update(widget.existing!.id, {
          'full_name': _name.text.trim(),
          'phone': _phone.text.trim().isEmpty ? null : _phone.text.trim(),
          'email': _email.text.trim().isEmpty ? null : _email.text.trim(),
          'tags': _parsedTags,
        });
      } else {
        await contacts.create(
          fullName: _name.text,
          phone: _phone.text,
          email: _email.text,
          tags: _parsedTags,
        );
      }

      if (!mounted) return;
      Navigator.pop(context, true);
      showAppSnack(context, _isEdit ? 'Contact updated' : 'Contact added');
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnack(context, e.message, isError: true);
    }
  }

  Future<void> _delete() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete ${widget.existing!.fullName}?',
      message: 'The contact is removed from your workspace. Existing '
          'conversations and campaign history are not deleted.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _saving = true);
    try {
      await context.read<AppServices>().contacts.delete(widget.existing!.id);
      if (!mounted) return;
      Navigator.pop(context, true);
      showAppSnack(context, 'Contact deleted');
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnack(context, e.message, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppFormSheet(
      title: _isEdit ? 'Edit contact' : 'New contact',
      trailing: _isEdit
          ? IconButton(
              onPressed: _saving ? null : _delete,
              icon: const Icon(Icons.delete_outline,
                  color: AppColors.dangerStrong),
              tooltip: 'Delete contact',
            )
          : null,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppInput(
              controller: _name,
              label: 'Full name',
              prefixIcon: Icons.person_outline,
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'A name is required' : null,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppInput(
              controller: _phone,
              label: 'Phone',
              hint: '+919876543210',
              helperText: 'Include the country code for WhatsApp',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return null;
                if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                  return 'Enter digits only, optionally starting with +';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            AppInput(
              controller: _email,
              label: 'Email',
              prefixIcon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return null;
                return value.contains('@') ? null : 'Enter a valid email';
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            AppInput(
              controller: _tags,
              label: 'Tags',
              hint: 'vip, mumbai',
              helperText: 'Separate with commas',
              prefixIcon: Icons.label_outline,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppNotice(
              icon: Icons.info_outline,
              message: 'A contact needs a phone number to be reachable on '
                  'WhatsApp.',
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: _isEdit ? 'Save changes' : 'Add contact',
              fullWidth: true,
              isLoading: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
