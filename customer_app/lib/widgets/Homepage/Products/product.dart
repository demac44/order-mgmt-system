import 'package:customer_app/services/cart.dart';
import 'package:flutter/material.dart';
import "../../../screens/product/index.dart";

class Product extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final int productId;
  final void Function() updateCart;
  final int cartItemCount;

  const Product({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.productId,
    required this.updateCart,
    required this.cartItemCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productId: productId, updateCart: updateCart, cartItemCount: cartItemCount),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 250,
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[400]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10), // Add this line
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Image.network(
                  height: double.infinity,
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
              width: double.infinity,
              child: 
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      'JOD ${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GestureDetector(
                          onTap: () {
                            CartService().addToCart({
                              'name': name,
                              'price': price,
                              'imageUrl': imageUrl,
                              'productId': productId,
                              'id': productId,
                            }).then((value) {
                              updateCart();
                            });
                          },
                          child: Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        )
                      ],
                    ),
                    
                  ],
                  )
          ],
          ))
          ],
        ),
      ),
    );
  }
}