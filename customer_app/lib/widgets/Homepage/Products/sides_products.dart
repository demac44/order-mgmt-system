import 'package:customer_app/services/menu.dart';
import 'package:flutter/material.dart';

import "../Products/product.dart";

class SidesProducts extends StatefulWidget {
  int cartItemCount;
  final void Function() updateCart;

  SidesProducts({Key? key, required this.cartItemCount, required this.updateCart}) : super(key: key);


  @override
  _SidesProductsState createState() => _SidesProductsState();
}

class _SidesProductsState extends State<SidesProducts> {
  List<dynamic> products = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  getProducts() async {
    var prod = await MenuService.getMenuItems({ 'isSide': true });
    setState(() {
      products = prod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: 
          products.map((product) {
            return Product(
              imageUrl: product['images'][0]['image'],
              name: product['name'],
              price: double.parse(product['price']),
              productId: product['id'],
              updateCart: widget.updateCart,
              cartItemCount: widget.cartItemCount,
            );
          }).toList(),
      ),
    );
  }
}