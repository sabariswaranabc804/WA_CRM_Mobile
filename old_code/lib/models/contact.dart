import '../core/json_utils.dart';

/// Mirrors `GET /api/v1/contacts`, which answers
/// `{ data: { contacts, total, limit, offset } }`.
class Contact {
  final int id;
  final String fullName;
  final String? phone;
  final String? email;
  final String? instagramHandle;
  final bool optedOutWhatsapp;
  final List<String> tags;
  final DateTime? createdAt;

  const Contact({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.instagramHandle,
    required this.optedOutWhatsapp,
    required this.tags,
    required this.createdAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: asInt(json['id']),
      fullName: asString(json['full_name'], 'Unnamed contact'),
      phone: asStringOrNull(json['phone']),
      email: asStringOrNull(json['email']),
      instagramHandle: asStringOrNull(json['instagram_handle']),
      optedOutWhatsapp: asBool(json['opted_out_whatsapp']),
      tags: asStringList(json['tags']),
      createdAt: asDate(json['created_at']),
    );
  }

  /// Best available secondary identifier, shown under the name.
  String get subtitle =>
      phone ?? email ?? instagramHandle ?? 'No contact details';
}

/// A page of contacts plus the offset cursor for the next one.
class ContactPage {
  final List<Contact> contacts;
  final int total;
  final int limit;
  final int offset;

  const ContactPage({
    required this.contacts,
    required this.total,
    required this.limit,
    required this.offset,
  });

  bool get hasMore => offset + contacts.length < total;

  factory ContactPage.fromJson(Map<String, dynamic> json) {
    return ContactPage(
      contacts: asMapList(json['contacts']).map(Contact.fromJson).toList(),
      total: asInt(json['total']),
      limit: asInt(json['limit'], 30),
      offset: asInt(json['offset']),
    );
  }
}
