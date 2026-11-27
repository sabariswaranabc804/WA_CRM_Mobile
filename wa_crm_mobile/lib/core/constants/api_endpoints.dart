/// Canonical API endpoints for the Bulk Chat server (v1).
class ApiEndpoints {
  static String baseUrl =
      "https://bulkchat360.akilamtechnologynexus.com/api/v1";
  //  "https://confidentiality-female-upgrades-swap.trycloudflare.com/api/v1";
  // "https://assistant-served-million-onto.trycloudflare.com/api/v1";

  // Auth
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String changePassword = '/auth/change-password';

  // Realtime
  static const String realtimeStream = '/realtime/stream';

  // Conversations & Messages
  static const String conversations = '/conversations';
  static const String conversationCounts = '/conversations/counts';
  static const String unreadCount = '/conversations/unread-count';
  static const String startConversation = '/conversations/start';
  static String conversation(int id) => '/conversations/$id';
  static String conversationThread(int id) => '/conversations/$id/thread';
  static String conversationMessages(int id) => '/conversations/$id/messages';
  static String conversationReply(int id) => '/conversations/$id/reply';
  static String conversationNotes(int id) => '/conversations/$id/notes';
  static String conversationNote(int id, int noteId) =>
      '/conversations/$id/notes/$noteId';
  static String conversationAssign(int id) => '/conversations/$id/assign';
  static String conversationStatus(int id) => '/conversations/$id/status';
  static String conversationClose(int id) => '/conversations/$id/close';
  static String conversationRead(int id) => '/conversations/$id/read';
  static String conversationTags(int id) => '/conversations/$id/tags';
  static String conversationTag(int id, int tagId) =>
      '/conversations/$id/tags/$tagId';
  static String conversationContact(int id) => '/conversations/$id/contact';
  static String messageMedia(int messageId) =>
      '/conversations/messages/$messageId/media';
  static String messageMediaInfo(int messageId) =>
      '/conversations/messages/$messageId/media/info';

  // Contacts & Segments
  static const String contacts = '/contacts';
  static const String contactTags = '/contacts/tags';
  static const String contactLists = '/contacts/lists';
  static String contact(int id) => '/contacts/$id';
  static String contactList(int id) => '/contacts/lists/$id';
  static String contactListPreview(int id) => '/contacts/lists/$id/preview';

  // Campaigns
  static const String campaigns = '/campaigns';
  static String campaign(int id) => '/campaigns/$id';
  static String campaignStats(int id) => '/campaigns/$id/stats';
  static String campaignRecipients(int id) => '/campaigns/$id/recipients';
  static String campaignLaunch(int id) => '/campaigns/$id/launch';
  static String campaignPause(int id) => '/campaigns/$id/pause';
  static String campaignCancel(int id) => '/campaigns/$id/cancel';

  // Templates
  static const String templates = '/templates';
  static const String syncTemplates = '/templates/sync';
  static String template(int id) => '/templates/$id';
  static String templateSubmit(int id) => '/templates/$id/submit';
  static String templateStatus(int id) => '/templates/$id/status';
  static String templateDuplicate(int id) => '/templates/$id/duplicate';

  // Teams, Channels, Notifications
  static const String channelAccounts = '/channel-accounts';
  static const String users = '/users';
  static const String teams = '/teams';
  static const String notifications = '/notifications';
  static const String notificationsUnreadCount = '/notifications/unread-count';
  static const String notificationsReadAll = '/notifications/read-all';
  static String notificationRead(int id) => '/notifications/$id/read';
}
