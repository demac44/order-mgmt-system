import 'dart:ffi';

import 'package:customer_app/screens/checkout/index.dart';
import 'package:customer_app/services/cart.dart';
import 'package:flutter/material.dart';
import '../../widgets/Header/header.dart';

class Cart extends StatefulWidget {
  int cartItemCount;
  void Function() updateCart;

  Cart({Key? key, required this.cartItemCount, required this.updateCart})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<dynamic> _cartItems = [];
  
  @override
  void initState() {
    super.initState();
    getCartItems();
  }

  Future<List<dynamic>> getCartItems() async {
    var items = await CartService().getCart();
    print(items);
    setState(() {
      _cartItems = items;
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(cartItemCount: widget.cartItemCount, updateCart: widget.updateCart),
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
                Text('Total: JOD ${CartService().getTotalPrice(_cartItems).toString()}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    CartService().clearCart();
                    widget.updateCart();
                    getCartItems();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, 
                    foregroundColor: Colors.white, 
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    alignment: Alignment.centerRight,
                  ),
                  child: const Text(
                    'Clear Cart',
                    style: TextStyle(
                    fontSize: 16,
                    ),
                  ),
                ),
              ],)
          ),
         
          const SizedBox(height: 40),
          _cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty', style: TextStyle(fontSize: 18)))
          : Expanded(
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
                  itemQuantity: item['quantity'] ?? 1,
                  increaseQuantity: () {
                    CartService().addToCart(item);
                    widget.updateCart();
                    getCartItems();
                  },
                  decreaseQuantity: () {
                    CartService().removeFromCart(item);
                    widget.updateCart();
                    getCartItems();
                  },
                  deleteItem: () {
                    CartService().deleteFromCart(item);
                    widget.updateCart();
                    getCartItems();
                  },
                ),
                const SizedBox(height: 15)
              ],
            ),
          );
        },
      ),
    ),
  ],),
    bottomNavigationBar: Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          _cartItems.isEmpty ? () {} : Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckoutScreen(updateCart: widget.updateCart, cartItemCount: widget.cartItemCount)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _cartItems.isEmpty ? Colors.grey : Colors.lightBlue, 
          // Set background color to light blue
        ),
        child: Text(
          'Checkout (JOD ${CartService().getTotalPrice(_cartItems).toString()})',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    ));
  }
}

class CartItem extends StatelessWidget {
  final String itemImage;
  final double itemPrice;
  final int itemQuantity;
  final String itemName;
  final void Function() increaseQuantity;
  final void Function() decreaseQuantity;
  final void Function() deleteItem;

  const CartItem({
    Key? key,
    required this.itemImage,
    required this.itemPrice,
    required this.itemQuantity,
    required this.increaseQuantity,
    required this.deleteItem,
    required this.decreaseQuantity,
    required this.itemName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image.network(itemImage),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(itemName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('JOD ${itemPrice}', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              ],)
            ],
          ),

          Row(
            children: [
              IconButton(
                onPressed: decreaseQuantity,
                icon: Icon(Icons.remove),
              ),
              Text(
                itemQuantity.toString(),
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: increaseQuantity,
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: deleteItem,
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      )
    );
  }
}
