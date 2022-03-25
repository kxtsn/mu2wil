class _LoginData {
  String email = '';
  String password = '';
}

class UserData extends _LoginData {
  String token = '';
  String email = '';
  int roleID = 0;

  void addData(Map<String, dynamic> responseMap) {
    this.roleID = responseMap["roleID"];
    this.email = responseMap["email"];
    this.token = responseMap["token"];
  }
}
