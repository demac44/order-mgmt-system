


import 'dart:convert';
import 'package:mgmt_app/services/api/api.dart';

class CashierOrdersService {


  Future<List<dynamic>> getOrders(String? status) async{
    dynamic response = await API.get('orders${status != null ? '?status=$status' : ''}');

    List<dynamic> orders = jsonDecode(response.body);

    return orders;
  }

  Future<dynamic> changeStatus(int orderId, String status) async{
    dynamic response = await API.get('orders/update-status/${orderId}/$status');

    return jsonDecode(response.body);
  }
  
}