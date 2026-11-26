import 'package:intl/intl.dart';

/// WhatsApp-style timestamp for the chat list: time today, "Yesterday",
/// weekday name within the last week, otherwise a short date.
String chatListTimestamp(DateTime? when) {
  if (when == null) return '';
  final now = DateTime.now();
  final day = DateTime(when.year, when.month, when.day);
  final today = DateTime(now.year, now.month, now.day);
  final diff = today.difference(day).inDays;

  if (diff == 0) return DateFormat.jm().format(when);
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return DateFormat.E().format(when);
  return DateFormat('dd/MM/yyyy').format(when);
}

/// Time shown inside a message bubble.
String bubbleTime(DateTime? when) =>
    when == null ? '' : DateFormat.jm().format(when);

/// Date separator between groups of messages in a thread.
String dayDivider(DateTime when) {
  final now = DateTime.now();
  final day = DateTime(when.year, when.month, when.day);
  final today = DateTime(now.year, now.month, now.day);
  final diff = today.difference(day).inDays;

  if (diff == 0) return 'TODAY';
  if (diff == 1) return 'YESTERDAY';
  return DateFormat('d MMMM yyyy').format(when).toUpperCase();
}

String fullDateTime(DateTime? when) =>
    when == null ? '—' : DateFormat('d MMM yyyy, h:mm a').format(when);

String shortDate(DateTime? when) =>
    when == null ? '—' : DateFormat('d MMM yyyy').format(when);

/// UTC ISO-8601 with exactly millisecond precision.
///
/// The campaign validator is `z.string().datetime({ precision: 3 })`, which
/// rejects both second-only and microsecond timestamps. `toIso8601String()`
/// emits microseconds whenever they are non-zero, so they are truncated first.
String toApiTimestamp(DateTime when) {
  final utc = when.toUtc();
  return DateTime.utc(
    utc.year,
    utc.month,
    utc.day,
    utc.hour,
    utc.minute,
    utc.second,
    utc.millisecond,
  ).toIso8601String();
}

/// Up to two initials for an avatar circle.
String initialsFor(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return '?';
  return parts.take(2).map((p) => p[0]).join().toUpperCase();
}

/// Slugify a workspace name the same way `login.use-case.js` does, so what the
/// user typed and what the server looks up agree.
String slugify(String input) => input
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
    .replaceAll(RegExp(r'^-+|-+$'), '');
