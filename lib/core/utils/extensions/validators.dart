extension UsernameValidator on String {
  bool isValidName() {
    return RegExp(
      r'^[A-Za-z\s\.]+$',
    ).hasMatch(this);
  }
}
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}

extension RollNoValidator on String {
  bool isValidRollNo() {
    return RegExp(
      r'^[0-9]{1,11}$',
    ).hasMatch(this);
  }
}
