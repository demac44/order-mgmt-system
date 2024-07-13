
import 'package:customer_app/services/cart.dart';
import 'package:customer_app/widgets/Cart/cart_item.dart';
import 'package:customer_app/widgets/Checkout/checkout_form.dart';
import 'package:flutter/material.dart';
import '../../widgets/Header/header.dart';

class CheckoutScreen extends StatefulWidget {
  int cartItemCount;
  void Function() updateCart;

  CheckoutScreen({Key? key, required this.cartItemCount, required this.updateCart})
      : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<dynamic> _cartItems = [];
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    super.initState();
    getCartItems();
  }

  Future<List<dynamic>> getCartItems() async {
    var items = await CartService().getCart();
    setState(() {
      _cartItems = items;
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(cartItemCount: widget.cartItemCount, updateCart: widget.updateCart),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[500]!))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: JOD ${CartService().getTotalPrice(_cartItems).toString()}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ],)
          ),
         
          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                var item = _cartItems[index];
                return Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  CartItem(
                    itemImage: item['imageUrl'],
                    itemName: item['name'],
                    itemPrice: item['price'],
                    itemQuantity: item['quantity'] ?? 1
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            );
          },
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: CheckoutForm(updateCart: widget.updateCart, cartItemCount: widget.cartItemCount),
      )
    ],
  )
  );
  }
} 

