import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  final _storage = const FlutterSecureStorage();

  final _keyUsername = 'username';
  final _token = 'token';
  final _responseKey = 'response';
  final _role = 'role';

  //general write to storage
  Future writeSecureData(String key, var value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  //general read to storage
  Future readSecureData(String key) async {
    var readData = await _storage.read(key: key);
    return readData;
  }

  //general delete data
  Future deleteSecureData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }

  //set Token
  Future setToken(String token) async {
    return await _storage.write(key: _token, value: token);
  }

  //get Token
  Future<String?> getToken() async {
    String? token = await _storage.read(key: _token);
    return token;
  }

  //set role
  Future setRole(String role) async {
    return await _storage.write(key: _role, value: role);
  }

  //get Role
  Future getRole() async {
    var role = await _storage.read(key: _role);
    return role;
  }

  //response JWT / user / roleID
  Future setResponseKey(String response) async {
    await _storage.write(key: _responseKey, value: response);
  }

  Future getResponseKey() async {
    var response = await _storage.read(key: _responseKey);
    return response;
  }

  Future setUsername(String username) async {
    await _storage.write(key: _keyUsername, value: username);
  }

  Future<String?> getUsername() async {
    await _storage.read(key: _keyUsername);
  }

  Future userDetails(String key, String value) async {
    var userDetails = await _storage.write(key: key, value: value);
    return userDetails;
  }

  Future logout() async {
    await _storage.deleteAll();
  }
}
