import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/debouncer.dart';
import '../../core/formatters.dart';
import '../../models/contact.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';
import 'contact_form_sheet.dart';

/// The Contacts tab: search, browse, add and edit.
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  static const _pageSize = 30;

  final _searchController = TextEditingController();
  final _searchDebounce = Debouncer(kSearchDebounce);

  List<Contact> _contacts = [];
  bool _loading = true;
  bool _loadingMore = false;
  bool _searching = false;
  String? _error;
  String _search = '';
  int _total = 0;

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

  Future<ContactPage> _fetch(int offset) {
    return context.read<AppServices>().contacts.list(
          search: _search.isEmpty ? null : _search,
          limit: _pageSize,
          offset: offset,
        );
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page = await _fetch(0);
      if (!mounted) return;
      setState(() {
        _contacts = page.contacts;
        _total = page.total;
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

  Future<void> _loadMore() async {
    if (_loadingMore || _loading || _contacts.length >= _total) return;
    setState(() => _loadingMore = true);

    try {
      final page = await _fetch(_contacts.length);
      if (!mounted) return;
      setState(() {
        final seen = _contacts.map((c) => c.id).toSet();
        _contacts.addAll(page.contacts.where((c) => !seen.contains(c.id)));
        _total = page.total;
        _loadingMore = false;
      });
    } on ApiException {
      if (!mounted) return;
      setState(() => _loadingMore = false);
    }
  }

  void _onSearchChanged(String value) {
    _searchDebounce.run(() {
      if (!mounted) return;
      setState(() => _search = value.trim());
      _load();
    });
  }

  void _closeSearch() {
    _searchController.clear();
    setState(() {
      _searching = false;
      _search = '';
    });
    _load();
  }

  Future<void> _openForm({Contact? existing}) async {
    final changed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ContactFormSheet(existing: existing),
    );
    if (changed == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _searching
          ? AppSearchAppBar(
              controller: _searchController,
              hint: 'Search name, phone or email…',
              onChanged: _onSearchChanged,
              onClose: _closeSearch,
            )
          : AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Contacts'),
                  if (!_loading && _error == null)
                    Text(
                      '$_total total',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subtitle(context),
                        height: 1.4,
                      ),
                    ),
                ],
              ),
              actions: [
                AppSearchAction(
                  tooltip: 'Search contacts',
                  onPressed: () => setState(() => _searching = true),
                ),
                AppRefreshAction(onPressed: _load),
              ],
            ),
      body: AppAsyncListView<Contact>(
        isLoading: _loading,
        error: _error,
        items: _contacts,
        isLoadingMore: _loadingMore,
        onRetry: _load,
        onRefresh: _load,
        onLoadMore: _loadMore,
        separator: const Divider(indent: 76, height: 1),
        emptyState: AppEmptyState(
          icon: Icons.people_outline_rounded,
          title: _search.isEmpty ? 'No contacts yet' : 'No matching contacts',
          message: _search.isEmpty
              ? 'Tap + to add your first contact.'
              : 'Nothing matches "$_search".',
        ),
        itemBuilder: (context, contact, _) => ContactTile(
          contact: contact,
          onTap: () => _openForm(existing: contact),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        tooltip: 'Add contact',
        child: const Icon(Icons.person_add_alt_1, size: 24),
      ),
    );
  }
}

/// One row in the contacts list.
class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;

  const ContactTile({super.key, required this.contact, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: AppAvatar(name: contact.fullName, id: contact.id),
      title: Row(
        children: [
          Expanded(
            child: Text(
              contact.fullName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.5,
              ),
            ),
          ),
          if (contact.optedOutWhatsapp)
            const AppBadge(label: 'Opted out', color: AppColors.danger),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxs),
          Text(contact.subtitle),
          if (contact.tags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Wrap(
                spacing: 5,
                runSpacing: AppSpacing.xs,
                children: contact.tags
                    .take(4)
                    .map((t) => AppBadge(label: t, color: AppColors.primary))
                    .toList(),
              ),
            ),
        ],
      ),
      trailing: Text(
        shortDate(contact.createdAt),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      isThreeLine: contact.tags.isNotEmpty,
    );
  }
}
