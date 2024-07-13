


import 'dart:convert';

import 'package:mgmt_app/services/api/api.dart';

class UsersService {


  Future<List<dynamic>> getUsers() async {
    final response = await API.get('admin/users');

    return jsonDecode(response.body);
  }


  
}