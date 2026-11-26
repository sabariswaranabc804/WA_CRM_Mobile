import '../core/json_utils.dart';

/// A connected sending account — for WhatsApp, one WABA phone number.
/// Mirrors `GET /api/v1/channel-accounts`.
class ChannelAccount {
  final int id;
  final String channel;
  final String label;
  final String status;

  /// Already masked by the server, e.g. "+9****4210".
  final String? displayPhoneNumber;
  final String? verifiedName;
  final String? qualityRating;

  const ChannelAccount({
    required this.id,
    required this.channel,
    required this.label,
    required this.status,
    required this.displayPhoneNumber,
    required this.verifiedName,
    required this.qualityRating,
  });

  factory ChannelAccount.fromJson(Map<String, dynamic> json) {
    return ChannelAccount(
      id: asInt(json['id']),
      channel: asString(json['channel'], 'whatsapp'),
      label: asString(json['label'], 'Unnamed account'),
      status: asString(json['status'], 'disconnected'),
      displayPhoneNumber: asStringOrNull(json['display_phone_number']),
      verifiedName: asStringOrNull(json['verified_name']),
      qualityRating: asStringOrNull(json['quality_rating']),
    );
  }

  bool get isConnected => status == 'connected';

  /// Best line to identify the account in a picker.
  String get subtitle =>
      displayPhoneNumber ?? verifiedName ?? channel.toUpperCase();
}
