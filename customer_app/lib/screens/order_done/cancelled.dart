

import 'dart:async';
import 'dart:math';
import 'package:customer_app/screens/home/index.dart';
import 'package:customer_app/services/orders.dart';
import 'package:flutter/material.dart';

class OrderCancelledScreen extends StatefulWidget {
  final int cartItemCount;
  final void Function() updateCart;
  final int orderId;

  OrderCancelledScreen({Key? key, required this.cartItemCount, required this.updateCart, required this.orderId}) : super(key: key);

  @override
  _OrderCancelledScreenState createState() => _OrderCancelledScreenState();
}

class _OrderCancelledScreenState extends State<OrderCancelledScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cancel,
              size: 100,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your order has been cancelled.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Thank you for choosing our service.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            cartItemCount: widget.cartItemCount,
                            updateCart: widget.updateCart,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('Continue Shopping'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 0),
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}