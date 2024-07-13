


import 'dart:convert';

import 'package:mgmt_app/config/config.dart';
import 'package:mgmt_app/services/api/api.dart';

class TablesService {


  Future<List<dynamic>> getTables() async {
    dynamic branchId = String.fromEnvironment('BRANCH_ID');
    var response = await API.get('tables?branchId=$branchId');

    return jsonDecode(response.body);
  }

  Future<dynamic> createTable(String code) async {
    dynamic branchId = String.fromEnvironment('BRANCH_ID');
    var response = await API.post('tables', {
      'branchId': branchId.toString(),
      'code': code.toString(),
    });

    return jsonDecode(response.body);
  }

  Future<dynamic> updateTable(int id, String code) async {
    var response = await API.patch('tables/$id', {
      'code': code,
    });

    return jsonDecode(response.body);
  }

  Future<dynamic> deleteTable(int id) async {
    var response = await API.delete('tables/$id');

    return jsonDecode(response.body);
  }
}