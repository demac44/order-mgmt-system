


import 'dart:convert';

import 'package:mgmt_app/services/api/api.dart';

class AdminOrdersService {


  Future<List<dynamic>> getOrders(String? status) async{
    dynamic response = await API.get('orders${status != null ? '?status=$status' : ''}');

    List<dynamic> orders = jsonDecode(response.body);

    return orders;
  }




}