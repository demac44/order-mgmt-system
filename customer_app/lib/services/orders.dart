import 'dart:convert';

import 'package:customer_app/config/api_config.dart';
import 'package:customer_app/services/cart.dart';
import 'package:http/http.dart' as http; 



class OrdersService {


  Future<dynamic> checkTableNumber(String tableId) async {
    var response = await http.get(Uri.parse('${apiConfig['baseUrl']}orders/table/$tableId'));
    if(response.body.isEmpty) return null;
    
    return jsonDecode(response.body);
  }

Future<dynamic> cancelOrder(int orderId) async {
    try {
      final response = await http.post(
        Uri.parse('${apiConfig['baseUrl']}orders/cancel/$orderId'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to cancel order');
      }
    } catch (e) {
      print('Error in cancelling order: $e');
    }
  }


  Future<dynamic> createOrder(String tableNumber, dynamic paymentInfo) async {

    var cart = await CartService().getCart();

    var order = {
      'items': jsonEncode(cart),
      'tableId': tableNumber.toString(),
      "paymentInfo": jsonEncode(paymentInfo),
      "paymentMethod": paymentInfo == null ? 'cash' : 'card'
    };

    try {
      final response = await http.post(
        Uri.parse('${apiConfig['baseUrl']}orders/create'), body: { ...order });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      print('Error in creating order: $e');
    }
  }

  Future<dynamic> getOrder(int orderId) async {
    try {
      final response = await http.get(
        Uri.parse('${apiConfig['baseUrl']}orders/$orderId'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get order');
      }
    } catch (e) {
      print('Error in getting order: $e');
    }
  }

}