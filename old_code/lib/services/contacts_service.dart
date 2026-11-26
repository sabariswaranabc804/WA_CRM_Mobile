import '../models/contact.dart';
import '../models/contact_list.dart';
import '../core/api_client.dart';
import '../core/json_utils.dart';

/// The Contacts tab.
class ContactsService {
  final ApiClient api;

  ContactsService(this.api);

  Future<ContactPage> list({
    String? search,
    String? tag,
    int limit = 30,
    int offset = 0,
  }) async {
    final data = await api.get('/contacts', query: {
      'search': search,
      'tag': tag,
      'limit': limit,
      'offset': offset,
    });
    return ContactPage.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<List<String>> tags() async {
    final data = await api.get('/contacts/tags');
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((t) => '${t['name']}')
        .where((t) => t.isNotEmpty)
        .toList();
  }

  /// Audiences a campaign can target.
  Future<List<ContactList>> lists() async {
    final data = await api.get('/contacts/lists');
    return asMapList(data).map(ContactList.fromJson).toList();
  }

  Future<Contact> create({
    required String fullName,
    String? phone,
    String? email,
    List<String> tags = const [],
  }) async {
    final data = await api.post('/contacts', body: {
      'full_name': fullName.trim(),
      if (phone != null && phone.trim().isNotEmpty) 'phone': phone.trim(),
      if (email != null && email.trim().isNotEmpty) 'email': email.trim(),
      if (tags.isNotEmpty) 'tags': tags,
    });
    return Contact.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<Contact> update(int id, Map<String, dynamic> changes) async {
    final data = await api.patch('/contacts/$id', body: changes);
    return Contact.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<void> delete(int id) => api.delete('/contacts/$id');
}
