
class Validators {
  Validators._();

  static String? requiredField(
    String? value, {
    required String fieldName,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your $fieldName';
    }
    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Enter your email';
    }

    final emailRegex = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }

    return null;
  }

  static String? workspace(String? value) {
    final workspace = value?.trim() ?? '';

    if (workspace.isEmpty) {
      return 'Enter your workspace';
    }

    // if (!RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9-]*$')
    //     .hasMatch(workspace)) {
    //   return 'Enter a valid workspace name';
    // }

    return null;
  }
}
