import "dart:convert";

import "package:mgmt_app/services/api/api.dart";


class CategoriesService {

  static Future<List<dynamic>> getCategories() async {
    final response = await API.get('categories');

    if (response.statusCode == 200) {
      List<dynamic> categories = jsonDecode(response.body);
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<void> addCategory(String name, String description, String image) async {
    final response = await API.post('categories', { 'name': name, 'description': description, 'image': image});

    if (response.statusCode != 201) {
      throw Exception('Failed to add category');
    }
  }

  static Future<void> deleteCategory(id) async {
    final response = await API.delete('categories/$id');

    if (response.statusCode != 204) {
      throw Exception('Failed to delete category');
    }
  }

  static Future<void> updateCategory(id, String name, String description, String image) async {
    final response = await API.patch('categories/$id', { 'name': name, 'description': description, 'image': image});

    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }
}