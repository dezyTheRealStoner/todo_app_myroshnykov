class EmailIsAlreadyUsedException implements Exception {
  EmailIsAlreadyUsedException();

  @override
  String toString() {
    return 'Email is already used exception';
  }
}
