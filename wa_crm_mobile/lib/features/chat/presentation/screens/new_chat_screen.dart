import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wa_crm_mobile/core/constants/api_endpoints.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/network/api_client_provider.dart';
import 'package:wa_crm_mobile/core/utils/debouncer.dart';
import 'package:wa_crm_mobile/features/chat/data/chat_repository.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_params.dart';
import 'package:wa_crm_mobile/features/chat/presentation/screens/chat_thread_screen.dart';
import 'package:wa_crm_mobile/shared/widgets/widgets.dart';

class NewChatScreen extends ConsumerStatefulWidget {
  const NewChatScreen({super.key});

  @override
  ConsumerState<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends ConsumerState<NewChatScreen> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(kSearchDebounce);
  List<Map<String, dynamic>> _contacts = [];
  bool _loading = true;
  bool _opening = false;
  String? _error;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final client = ref.read(apiClientProvider);
      final query = <String, dynamic>{
        'limit': 50,
        if (_search.isNotEmpty) 'search': _search,
      };

      final response = await client.getApiConnection(
        url: ApiEndpoints.contacts,
        queryParameters: query,
      );

      List<dynamic> items = [];
      if (response is Map && response['data'] is List) {
        items = response['data'] as List<dynamic>;
      } else if (response is Map && response['contacts'] is List) {
        items = response['contacts'] as List<dynamic>;
      } else if (response is List) {
        items = response;
      }

      final list = items
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      if (!mounted) return;
      setState(() {
        _contacts = list;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Unable to load contacts list.';
        _loading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      if (!mounted) return;
      setState(() => _search = query.trim());
      _loadContacts();
    });
  }

  Future<void> _openChat(Map<String, dynamic> contact) async {
    if (_opening) return;
    setState(() => _opening = true);

    final contactId = int.tryParse(contact['id'].toString()) ?? 0;
    final contactName = contact['name']?.toString();
    final contactPhone = contact['phone']?.toString();

    try {
      final repo = ref.read(chatRepositoryProvider);
      final conversations = await repo.listConversations(
        ListConversationsParams(search: contactPhone ?? contactName, limit: 100),
      );

      final match = conversations.data.where((c) => c.contactId == contactId);

      if (!mounted) return;

      if (match.isNotEmpty) {
        final existing = match.first;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ChatThreadScreen(conversation: existing),
          ),
        );
      } else {
        showAppSnack(
          context,
          'No active WhatsApp thread with this contact yet. Send an outreach campaign or trigger a template to begin.',
        );
      }
    } catch (e) {
      if (mounted) showAppSnack(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _opening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface(context),
      appBar: AppSearchAppBar(
        controller: _searchController,
        hint: 'Search contacts by name or phone...',
        onChanged: _onSearchChanged,
        onClose: () => Navigator.of(context).pop(),
      ),
      body: AppAsyncListView<Map<String, dynamic>>(
        isLoading: _loading,
        items: _contacts,
        error: _error,
        onRetry: _loadContacts,
        emptyState: AppEmptyState(
          icon: Icons.contacts_outlined,
          title: 'No Contacts Found',
          message: _search.isNotEmpty
              ? 'No contact matches "$_search".'
              : 'Your CRM contacts directory will appear here.',
        ),
        itemBuilder: (context, contact, index) {
          final id = int.tryParse(contact['id'].toString()) ?? index;
          final name = contact['name']?.toString() ?? 'Unnamed Contact';
          final phone = contact['phone']?.toString() ?? 'No phone number';

          return ListTile(
            leading: AppAvatar(
              name: name,
              id: id,
              radius: 22,
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              phone,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.subtitle(context),
              ),
            ),
            trailing:  Icon(
              Icons.chat_bubble_outline_rounded,
              color: AppColors.secondary600,
              size: 20,
            ),
            onTap: _opening ? null : () => _openChat(contact),
          );
        },
      ),
    );
  }
}
