import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mgmt_app/config/api_config.dart';
import 'package:mgmt_app/services/auth/auth.dart';


class API {

  static Future<http.Response> get(String pathname) async {
    final String sid = await getSid();
    return await http.get(Uri.parse('${ApiConfig['baseUrl']}$pathname'), headers: { 'cookie': sid });
  }

  static Future<http.Response> post(String pathname, dynamic data) async {
    final String sid = await getSid();
    return await http.post(Uri.parse('${ApiConfig['baseUrl']}$pathname'), body: data, headers: { 'cookie': sid });
  }

  static Future<http.Response> put(String pathname, Map<String, dynamic> data) async {
    final String sid = await getSid();
    return await http.put(Uri.parse('${ApiConfig['baseUrl']}$pathname'), body: data, headers: { 'cookie': sid });
  }

  static Future<http.Response> delete(String pathname) async {
    final String sid = await getSid();
    return await http.delete(Uri.parse('${ApiConfig['baseUrl']}$pathname'), headers: { 'cookie': sid });
  }

  static Future<http.Response> patch(String pathname, Map<String, dynamic> data) async {
    final String sid = await getSid();
    return await http.patch(Uri.parse('${ApiConfig['baseUrl']}$pathname'), body: data, headers: { 'cookie': sid });
  }


  static Future<String> getSid() async {
    return await AuthService.getSessionId() ?? '';
  }


}


