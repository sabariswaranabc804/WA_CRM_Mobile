import '../core/api_client.dart';
import '../core/json_utils.dart';
import '../models/template.dart';

/// The Templates tab.
///
/// Browsing and submitting for review. Authoring a template (header, buttons,
/// variable samples) is a desktop-sized job and stays on the web client.
class TemplatesService {
  final ApiClient api;

  TemplatesService(this.api);

  Future<List<MessageTemplate>> list({
    String status = 'all',
    String? search,
  }) async {
    final data = await api.get('/templates', query: {
      'channel': 'whatsapp',
      'status': status,
      'search': search,
    });
    return asMapList(data).map(MessageTemplate.fromJson).toList();
  }

  /// Only approved templates are offered in the reply composer.
  Future<List<MessageTemplate>> approved() => list(status: 'approved');

  Future<MessageTemplate> getById(int id) async {
    final data = await api.get('/templates/$id');
    return MessageTemplate.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<void> submit(int id) => api.post('/templates/$id/submit');

  /// Pulls the latest review status for one template from Meta.
  Future<void> refreshStatus(int id) => api.get('/templates/$id/status');

  /// Imports every template already on the connected WABA.
  Future<Map<String, dynamic>> syncAll() async {
    final data = await api.post('/templates/sync');
    return data is Map ? Map<String, dynamic>.from(data) : {};
  }
}
