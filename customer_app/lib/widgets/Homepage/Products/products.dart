import 'package:flutter/material.dart';
import "../Products/product.dart";

class Products extends StatelessWidget {
  final void Function() updateCart;
  final int cartItemCount;
  final List<dynamic> products;

  const Products({Key? key, required this.updateCart, required this.cartItemCount, required this.products});


  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,),
        children: products.map((product){
          return Product(
              imageUrl: product['images'][0]['image'],
              name: product['name'],
              price: double.parse(product['price']),
              productId: product['id'],
              updateCart: updateCart,
              cartItemCount: cartItemCount
            );
        }).toList()
    );
  }
}