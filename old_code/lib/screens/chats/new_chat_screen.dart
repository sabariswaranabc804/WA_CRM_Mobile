import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/debouncer.dart';
import '../../models/contact.dart';
import '../../models/conversation.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';

/// The "+" destination: pick a contact to open their chat.
///
/// The tenant API has no `POST /conversations` — threads are opened by an
/// inbound webhook, an automation or a campaign — so this screen can open an
/// existing conversation but cannot start one from scratch. When a contact has
/// no thread yet, it says so plainly rather than failing silently.
class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final _searchController = TextEditingController();
  final _searchDebounce = Debouncer(kSearchDebounce);

  List<Contact> _contacts = [];
  bool _loading = true;
  bool _opening = false;
  String? _error;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchDebounce.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page = await context.read<AppServices>().contacts.list(
            search: _search.isEmpty ? null : _search,
            limit: 50,
          );
      if (!mounted) return;
      setState(() {
        _contacts = page.contacts;
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

  void _onSearchChanged(String value) {
    _searchDebounce.run(() {
      if (!mounted) return;
      setState(() => _search = value.trim());
      _load();
    });
  }

  Future<void> _openChat(Contact contact) async {
    if (_opening) return;
    setState(() => _opening = true);

    try {
      final conversation =
          await context.read<AppServices>().inbox.findByContact(
                contact.id,
                searchHint: contact.phone ?? contact.fullName,
              );

      if (!mounted) return;

      if (conversation != null) {
        Navigator.pop<Conversation>(context, conversation);
        return;
      }

      await showConfirmDialog(
        context,
        title: 'No conversation yet',
        message: '${contact.fullName} has not messaged your WhatsApp number '
            'yet.\n\nWhatsApp only lets a business open a new thread with an '
            'approved template, which this app cannot send yet. Reach them '
            'with a campaign from the web app instead.',
        confirmLabel: 'Got it',
        cancelLabel: 'Close',
      );
    } on ApiException catch (e) {
      if (mounted) showAppSnack(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _opening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New chat'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: AppSearchField(
              controller: _searchController,
              hint: 'Search contacts…',
              onChanged: _onSearchChanged,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          AppAsyncListView<Contact>(
            isLoading: _loading,
            error: _error,
            items: _contacts,
            onRetry: _load,
            onRefresh: _load,
            separator: const Divider(indent: 76, height: 1),
            emptyState: AppEmptyState(
              icon: Icons.person_search_outlined,
              title: _search.isEmpty ? 'No contacts' : 'No matching contacts',
              message: _search.isEmpty
                  ? 'Add contacts from the Contacts tab first.'
                  : 'Nothing matches "$_search".',
            ),
            itemBuilder: (context, contact, _) => ListTile(
              onTap: () => _openChat(contact),
              leading: AppAvatar(
                name: contact.fullName,
                id: contact.id,
                radius: 22,
              ),
              title: Text(
                contact.fullName,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(contact.subtitle),
            ),
          ),
          if (_opening)
            const ColoredBox(
              color: Color(0x33000000),
              child: AppLoader(),
            ),
        ],
      ),
    );
  }
}
