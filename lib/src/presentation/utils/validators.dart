const minNameLength = 3;
const maxNameLength = 18;

bool validateName(String value) {
  final username = value.trim();

  final regex = RegExp(r'^[a-zA-Z0-9_ ]+$');

  return regex.hasMatch(username) &&
      username.length >= minNameLength &&
      username.length <= maxNameLength;
}

bool validateEmail(String value) {
  final email = value.trim();

  return email.contains('@');
}

bool validatePassword(String value) {
  final password = value.trim();

  final regex = RegExp(r'^([A-Z])(?=.*\d)[a-zA-Z\d\w\W]{6,}$');

  return regex.hasMatch(password);
}

bool validateConfirmedPassword({
  required String password,
  required String confirmedPassword,
}) {
  return password.trim() == confirmedPassword.trim();
}
