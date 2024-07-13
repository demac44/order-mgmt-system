import "package:customer_app/config/config.dart";
import 'package:http/http.dart' as http;
import "../config/api_config.dart";
import "../data/menu.dart";
import 'dart:convert';
import "../util/CreateHttpParams.dart";

class MenuService {
  static final String? baseUrl = apiConfig['baseUrl'];

    static Future<dynamic> getMenuItem(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}menu/item/$id'));
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load menu items');
    }
  }
  
  static Future<List<dynamic>> getMenuItems(dynamic filters) async {
    const branchId = String.fromEnvironment('BRANCH_ID');
    dynamic url = Uri.parse('${baseUrl}menu/items/$branchId${createHttpParams(filters)})');
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  static Future<List<dynamic>> getPopularItems() async {
    const branchId = String.fromEnvironment('BRANCH_ID');
    final response = await http.get(Uri.parse('${baseUrl}menu/popular/$branchId'));
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load popular items');
    }
  }


}