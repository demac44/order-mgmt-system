

import 'dart:convert';

import 'package:mgmt_app/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {

  static authenticate() async {
    final response = await API.get('auth');

    return response;
  }

  static login(String username, String password) async {
    final response = await API.post('auth/login', { 'username': username, 'password': password });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final sessionId = response.headers['set-cookie'].toString();

      setSessionId(sessionId);
      setSessionUser(jsonDecode(response.body));
    }

    return jsonDecode(response.body);

  }


  static getSessionId() async {
    final prefs = await SharedPreferences.getInstance();

    final sid = prefs.get('sid');

    return sid;
  }


  static setSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    
    final sid = prefs.setString('sid', sessionId);

    return sid;
  }

  static setSessionUser(dynamic user) async {
    final prefs = await SharedPreferences.getInstance();

    final sid = prefs.setString('user', jsonEncode(user));

    return sid;
  }

  static getSessionUser() async {
    final prefs = await SharedPreferences.getInstance();

    final String user = prefs.get('user').toString();

    return jsonDecode(user);
  }
}