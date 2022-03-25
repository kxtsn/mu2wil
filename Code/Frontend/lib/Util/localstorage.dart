import 'package:localstorage/localstorage.dart';

class UserLocalStorage {
  final _localstorage = LocalStorage('localstorage');

  final _response = 'response';
  final _token = 'token';
  final _role = 'role';

  Future setResponesKey(String value) async {
    var writeData = await _localstorage.setItem(_response, value);
    return writeData;
  }

  Future getResponseKey() async {
    await _localstorage.ready;
    var readData = await _localstorage.getItem(_response);
    return readData;
  }

  Future setToken(String value) async {
    var writeData = await _localstorage.setItem(_token, value);
    return writeData;
  }

  Future getToken() async {
    await _localstorage.ready;
    var readData = await _localstorage.getItem(_token);
    return readData;
  }

  Future setRole(String value) async {
    var writeData = await _localstorage.setItem(_role, value);
    return writeData;
  }

  Future getRole() async {
    await _localstorage.ready;
    var readData = await _localstorage.getItem(_role);
    return readData;
  }

  Future logout() async {
    _localstorage.clear();
  }
}
