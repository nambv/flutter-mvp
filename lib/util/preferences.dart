import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String _token = "PREF_TOKEN";

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token);
  }

  void setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_token, token);
  }
}
