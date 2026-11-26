import '../core/json_utils.dart';

/// Mirrors `GET /api/v1/campaigns`.
class Campaign {
  final int id;
  final String name;
  final String channel;
  final String status;
  final int? templateId;
  final DateTime? scheduledAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int totalRecipients;
  final int sentCount;
  final int deliveredCount;
  final int failedCount;

  /// Ordered values for the template's `{{n}}` placeholders, shared by every
  /// recipient. Empty when the template has none.
  final List<String> templateVariables;

  final DateTime? createdAt;

  const Campaign({
    required this.id,
    required this.name,
    required this.channel,
    required this.status,
    required this.templateId,
    required this.scheduledAt,
    required this.startedAt,
    required this.completedAt,
    required this.totalRecipients,
    required this.sentCount,
    required this.deliveredCount,
    required this.failedCount,
    required this.templateVariables,
    required this.createdAt,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: asInt(json['id']),
      name: asString(json['name'], 'Untitled campaign'),
      channel: asString(json['channel'], 'whatsapp'),
      status: asString(json['status'], 'draft'),
      templateId: asIntOrNull(json['template_id']),
      scheduledAt: asDate(json['scheduled_at']),
      startedAt: asDate(json['started_at']),
      completedAt: asDate(json['completed_at']),
      totalRecipients: asInt(json['total_recipients']),
      sentCount: asInt(json['sent_count']),
      deliveredCount: asInt(json['delivered_count']),
      failedCount: asInt(json['failed_count']),
      templateVariables: asStringList(json['template_variables']),
      createdAt: asDate(json['created_at']),
    );
  }

  /// Send progress in 0..1, or null when there is nothing to send yet.
  double? get progress {
    if (totalRecipients <= 0) return null;
    return (sentCount / totalRecipients).clamp(0.0, 1.0);
  }
}
