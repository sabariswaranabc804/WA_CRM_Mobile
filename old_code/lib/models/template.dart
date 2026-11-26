import '../core/json_utils.dart';

/// A declared placeholder. [sample] is the example value shown to Meta's
/// reviewers — useful to prefill a real value, but never sent itself.
class TemplateVariable {
  final String name;
  final String? sample;

  const TemplateVariable({required this.name, this.sample});

  factory TemplateVariable.fromJson(Map<String, dynamic> json) {
    return TemplateVariable(
      name: asString(json['name']),
      sample: asStringOrNull(json['sample']),
    );
  }
}

/// A button attached to a WhatsApp template.
class TemplateButton {
  final String type;
  final String text;

  const TemplateButton({required this.type, required this.text});

  factory TemplateButton.fromJson(Map<String, dynamic> json) {
    return TemplateButton(
      type: asString(json['type'], 'QUICK_REPLY'),
      text: asString(json['text'], 'Button'),
    );
  }
}

/// Mirrors `GET /api/v1/templates`.
class MessageTemplate {
  final int id;
  final String name;
  final String channel;
  final String? category;
  final String language;
  final String body;
  final String? headerType;
  final String? headerText;
  final String? footerText;
  final List<TemplateButton> buttons;
  final List<TemplateVariable> variables;
  final String status;
  final String? rejectionReason;
  final DateTime? updatedAt;

  const MessageTemplate({
    required this.id,
    required this.name,
    required this.channel,
    required this.category,
    required this.language,
    required this.body,
    required this.headerType,
    required this.headerText,
    required this.footerText,
    required this.buttons,
    required this.variables,
    required this.status,
    required this.rejectionReason,
    required this.updatedAt,
  });

  factory MessageTemplate.fromJson(Map<String, dynamic> json) {
    return MessageTemplate(
      id: asInt(json['id']),
      name: asString(json['name'], 'untitled'),
      channel: asString(json['channel'], 'whatsapp'),
      category: asStringOrNull(json['category']),
      language: asString(json['language'], 'en'),
      body: asString(json['body']),
      headerType: asStringOrNull(json['header_type']),
      headerText: asStringOrNull(json['header_text']),
      footerText: asStringOrNull(json['footer_text']),
      buttons: asMapList(json['buttons']).map(TemplateButton.fromJson).toList(),
      variables:
          asMapList(json['variables']).map(TemplateVariable.fromJson).toList(),
      status: asString(json['status'], 'draft'),
      rejectionReason: asStringOrNull(json['rejection_reason']),
      updatedAt: asDate(json['updated_at']),
    );
  }

  bool get isApproved => status == 'approved';

  /// Only approved templates can open a conversation outside the 24h window.
  bool get canSend => isApproved;

  /// The distinct `{{n}}` indices in the body, in order.
  ///
  /// Derived from the body rather than trusted from `variables`, because an
  /// imported template can carry placeholders it never declared. Distinct
  /// because Meta takes one value per index even if the body repeats it.
  List<int> get placeholderIndices {
    final found = <int>{};
    for (final match in RegExp(r'\{\{\s*(\d+)\s*\}\}').allMatches(body)) {
      final index = int.tryParse(match.group(1)!);
      if (index != null) found.add(index);
    }
    final sorted = found.toList()..sort();
    return sorted;
  }

  int get placeholderCount => placeholderIndices.length;

  bool get hasVariables => placeholderCount > 0 || variables.isNotEmpty;

  /// Label for the nth placeholder, falling back to its number.
  String labelFor(int position) {
    if (position < variables.length && variables[position].name.isNotEmpty) {
      return variables[position].name;
    }
    final indices = placeholderIndices;
    final number = position < indices.length ? indices[position] : position + 1;
    return 'Value {{$number}}';
  }

  /// Meta's review sample for the nth placeholder, used to prefill the field.
  String? sampleFor(int position) =>
      position < variables.length ? variables[position].sample : null;

  /// The body with [values] substituted, for a live preview.
  String preview(List<String> values) {
    var rendered = body;
    final indices = placeholderIndices;
    for (var i = 0; i < indices.length; i++) {
      final value = i < values.length && values[i].trim().isNotEmpty
          ? values[i]
          : '{{${indices[i]}}}';
      rendered = rendered.replaceAll(
        RegExp(r'\{\{\s*' + indices[i].toString() + r'\s*\}\}'),
        value,
      );
    }
    return rendered;
  }
}
