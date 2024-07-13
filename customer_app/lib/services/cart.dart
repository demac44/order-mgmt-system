


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CartService {

  dynamic createCart() async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.setString('cart', jsonEncode([]));

    return true;
  }

  dynamic addToCart(item) async {
    final prefs = await SharedPreferences.getInstance();

    dynamic cart = prefs.get('cart') as String;

    cart = jsonDecode(cart) as List<dynamic>;

    var existingItem = cart.firstWhere((element) => element['productId'] == item['productId'], orElse: () => null);

    if(existingItem == null){
      cart.add({ ...item, 'quantity': 1 });
    } else {
      cart[cart.indexOf(existingItem)]['quantity'] += 1;
    }


    prefs.setString('cart', jsonEncode(cart));


    return cart;
  }

  void removeFromCart(item) async {
    final prefs = await SharedPreferences.getInstance();

    dynamic cart = prefs.get('cart') as String;

    cart = jsonDecode(cart) as List<dynamic>;  

    var copy = List.from(cart);

    for(var i = 0; i < copy.length; i++) {
      if(copy[i]['productId'] == item['productId']) {
        if(copy[i]['quantity'] > 1) {
          copy[i]['quantity'] -= 1;
        } else {
          copy.removeAt(i);
        }
        break;
      }
    }

    prefs.setString('cart', jsonEncode(copy));
  }

  Future<void> deleteFromCart(item) async {
    final prefs = await SharedPreferences.getInstance();

    dynamic cart = prefs.get('cart') as String;

    cart = jsonDecode(cart) as List<dynamic>;  

    cart.removeWhere((element) => element['productId'] == item['productId']);

    prefs.setString('cart', jsonEncode(cart));
  }

  dynamic clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.setString('cart', jsonEncode([]));

    return true;
  }

  Future<List<dynamic>> getCart() async {
    final prefs = await SharedPreferences.getInstance();

    dynamic cart = prefs.get('cart') as String;

    cart = jsonDecode(cart) as List<dynamic>; 

    return cart; 
  }

  Future<int> getCartItemCount() async {
    final prefs = await SharedPreferences.getInstance();

    dynamic cart = prefs.get('cart') as String;

    if(cart == null) return 0;

    cart = jsonDecode(cart) as List<dynamic>;

    num count = 0;

    for(var item in cart) {
      count += item['quantity'];
    }

    return count.toInt();
  }

  double getTotalPrice(_cartItems) {

    double totalPrice = 0;

    for(var item in _cartItems) {
      totalPrice += item['price'] * item['quantity'];
    }

    return double.parse(totalPrice.toStringAsFixed(2));
  }
}