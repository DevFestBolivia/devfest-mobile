class EmailValidator {
  static bool validate(String value) {
    if (value.isEmpty) {
      return false;
    }
    return RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    ).hasMatch(value);
  }
}
