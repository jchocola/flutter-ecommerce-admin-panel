class TValidator {

  static String? validateEmptyText(String? fieldName, String? value) {
    if(value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if(username == null || username.isEmpty) {
      return 'Username is required';
    }

    const pattern = r"^[a-zA-Z0-9_-]{3,20}$";

    final regex = RegExp(pattern);

    bool isValid = regex.hasMatch(username);
  }
}