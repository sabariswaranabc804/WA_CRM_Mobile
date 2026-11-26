import '../core/api_client.dart';
import '../core/formatters.dart';
import '../core/json_utils.dart';
import '../models/campaign.dart';

/// The Campaigns tab.
///
/// Read and lifecycle control only. Composing a campaign needs a template, a
/// contact list and a channel account picker, which stays on the web client.
class CampaignsService {
  final ApiClient api;

  CampaignsService(this.api);

  Future<List<Campaign>> list({String status = 'all', int limit = 50}) async {
    final data = await api.get('/campaigns', query: {
      'channel': 'whatsapp',
      'status': status,
      'limit': limit,
    });
    return asMapList(data).map(Campaign.fromJson).toList();
  }

  Future<Campaign> getById(int id) async {
    final data = await api.get('/campaigns/$id');
    return Campaign.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<Campaign> stats(int id) async {
    final data = await api.get('/campaigns/$id/stats');
    return Campaign.fromJson(Map<String, dynamic>.from(data as Map));
  }

  /// Creates a campaign.
  ///
  /// The server derives the status from [scheduledAt]: a time makes it
  /// `scheduled`, omitting one leaves it a `draft` to launch by hand.
  Future<Campaign> create({
    required String name,
    required int channelAccountId,
    required int templateId,
    required int contactListId,
    DateTime? scheduledAt,
    List<String> templateVariables = const [],
    String channel = 'whatsapp',
  }) async {
    final data = await api.post('/campaigns', body: {
      'name': name.trim(),
      'channel': channel,
      'channel_account_id': channelAccountId,
      'template_id': templateId,
      'contact_list_id': contactListId,
      // One value per {{n}} in the template body; the server rejects a
      // mismatch rather than letting Meta fail every send.
      if (templateVariables.isNotEmpty)
        'template_variables':
            templateVariables.map((v) => v.trim()).toList(),
      // The validator demands exactly millisecond precision, in UTC.
      'scheduled_at': scheduledAt == null ? null : toApiTimestamp(scheduledAt),
    });
    return Campaign.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<void> launch(int id) => api.post('/campaigns/$id/launch');
  Future<void> pause(int id) => api.post('/campaigns/$id/pause');
  Future<void> cancel(int id) => api.post('/campaigns/$id/cancel');
}
