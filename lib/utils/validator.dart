class Validator {
  static String? validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (value != null && !regex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (value != null && !regex.hasMatch(value)) {
      return 'Password must be at least 6 characters.';
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (value != null && !regex.hasMatch(value.trim())) {
      return 'Please enter a name.';
    } else {
      return null;
    }
  }

  static String? validateNumber(String? value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);
    if (value != null && !regex.hasMatch(value)) {
      return 'Please enter a number.';
    } else {
      return null;
    }
  }
}
