import '../core/json_utils.dart';

/// An audience for a campaign. Mirrors `GET /api/v1/contacts/lists`.
///
/// `static` lists hold a fixed set of contacts; `dynamic` lists are rebuilt
/// from filter rules, so their size can change between now and send time.
class ContactList {
  final int id;
  final String name;
  final String type;

  const ContactList({
    required this.id,
    required this.name,
    required this.type,
  });

  factory ContactList.fromJson(Map<String, dynamic> json) {
    return ContactList(
      id: asInt(json['id']),
      name: asString(json['name'], 'Untitled list'),
      type: asString(json['type'], 'static'),
    );
  }

  bool get isDynamic => type == 'dynamic';
}
