import '../core/api_client.dart';
import '../core/json_utils.dart';
import '../models/channel_account.dart';

/// Connected sending accounts.
///
/// `GET /channel-accounts` is gated on the CHANNEL_MANAGE permission, so an
/// agent without it gets a 403 — callers should treat that as "cannot compose
/// a campaign here" rather than as a hard error.
class ChannelsService {
  final ApiClient api;

  ChannelsService(this.api);

  Future<List<ChannelAccount>> list() async {
    final data = await api.get('/channel-accounts');
    return asMapList(data).map(ChannelAccount.fromJson).toList();
  }

  /// Connected WhatsApp senders, which is all a campaign can use today.
  Future<List<ChannelAccount>> whatsappSenders() async {
    final accounts = await list();
    return accounts
        .where((a) => a.channel == 'whatsapp' && a.isConnected)
        .toList();
  }
}
