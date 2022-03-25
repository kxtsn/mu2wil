import 'package:shared_preferences/shared_preferences.dart';

class SharingPreference {
  final added_items = 'added_items';

  SharingPreference._privateConstructor();

  static final SharingPreference instance =
      SharingPreference._privateConstructor();

  Future<void> addExtraItems(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(added_items, value);
  }

  Future getExtraItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(added_items);
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
