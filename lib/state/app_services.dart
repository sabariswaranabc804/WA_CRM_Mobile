import '../core/api_client.dart';
import '../core/token_storage.dart';
import '../services/auth_service.dart';
import '../services/campaigns_service.dart';
import '../services/channels_service.dart';
import '../services/contacts_service.dart';
import '../services/inbox_service.dart';
import '../services/templates_service.dart';

/// One shared API client plus the services built on it, handed down through
/// the widget tree with Provider.
class AppServices {
  final TokenStorage storage;
  final ApiClient api;

  late final AuthService auth = AuthService(api);
  late final InboxService inbox = InboxService(api);
  late final ContactsService contacts = ContactsService(api);
  late final CampaignsService campaigns = CampaignsService(api);
  late final TemplatesService templates = TemplatesService(api);
  late final ChannelsService channels = ChannelsService(api);

  AppServices._(this.storage, this.api);

  factory AppServices.create() {
    final storage = TokenStorage();
    return AppServices._(storage, ApiClient(storage));
  }
}
