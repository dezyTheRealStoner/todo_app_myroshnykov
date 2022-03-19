class IncorrectEmailOrPasswordException implements Exception {
  IncorrectEmailOrPasswordException();

  @override
  String toString() {
    return 'Incorrect email or password exception';
  }
}
