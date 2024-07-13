

import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String itemImage;
  final double itemPrice;
  final int itemQuantity;
  final String itemName;

  const CartItem({
    Key? key,
    required this.itemImage,
    required this.itemPrice,
    required this.itemQuantity,
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
              Text('$itemQuantity x $itemName', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('JOD ${(itemPrice * itemQuantity).toStringAsFixed(2)}', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              ],)
            ],
          )
        ],
      )
    );
  }
}

