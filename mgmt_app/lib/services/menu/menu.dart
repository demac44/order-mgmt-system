


import 'dart:convert';

import 'package:mgmt_app/config/api_config.dart';
import 'package:mgmt_app/config/config.dart';
import 'package:mgmt_app/services/api/api.dart';
import 'package:http/http.dart' as http;

class MenuService {


  static Future<List<dynamic>> getMenus () async {
    var response = await API.get('menu/branch/${String.fromEnvironment('BRANCH_ID')}/all');

    return jsonDecode(response.body) as List<dynamic>;
  }

  static Future<dynamic> getMenu (int menuId) async {
    var response = await API.get('menu/$menuId');

    return jsonDecode(response.body);
  }

  static Future<dynamic> addMenu (String name, String description, String image) async {
    var response = await API.post('menu', {
      'name': name.toString(),
      'description': description.toString(),
      'branchId': String.fromEnvironment('BRANCH_ID')
    });

    return jsonDecode(response.body);
  }

  static Future<dynamic> deleteMenu (int menuId) async {
    var response = await API.delete('menu/$menuId');

    return jsonDecode(response.body);
  }

  static Future<dynamic> addMenuItem (int menuId, String name, String description, double price, int quantity, int categoryId, List<dynamic> images, bool isSide) async {
    return await API.post('menu/item', {
      'name': name,
      'description': description,
      'price': price.toString(),
      'menuId': menuId.toString(),
      'categoryId': categoryId.toString(),
      'images': jsonEncode(images),
      'quantity': quantity.toString(),
      'isSide': isSide.toString()
    });
  }


  static Future<dynamic> edit (int itemId, String name, String description, String price, int quantity, int categoryId, List<dynamic> images, bool isSide) async {
    return await API.patch('menu/item/$itemId', {
      'name': name,
      'description': description,
      'price': price.toString(),
      'categoryId': categoryId.toString(),
      'images': jsonEncode(images),
      'quantity': quantity.toString(),
      'isSide': isSide.toString()
    });
  }

  static Future<dynamic> deleteMenuItem (int menuItemId) async {
    return await API.delete('menu/item/$menuItemId');
  }


}