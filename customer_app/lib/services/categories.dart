import 'dart:convert';

import 'package:customer_app/config/api_config.dart';
import 'package:http/http.dart' as http;


class CategoriesService {


  static Future<List<dynamic>> getCategories() async {
    var response = await http.get(Uri.parse('${apiConfig['baseUrl']}categories'));

    return jsonDecode(response.body);
  }

}
