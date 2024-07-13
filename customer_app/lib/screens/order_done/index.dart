import 'dart:async';
import 'dart:math';
import 'package:customer_app/screens/home/index.dart';
import 'package:customer_app/screens/order_done/cancelled.dart';
import 'package:customer_app/services/orders.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDoneScreen extends StatefulWidget {
  final int cartItemCount;
  final void Function() updateCart;
  final int orderId;
  final double estimatedTime;
  final String invoice;

  OrderDoneScreen({Key? key, required this.cartItemCount, required this.updateCart, required this.orderId, required this.estimatedTime, required this.invoice}) : super(key: key);

  @override
  _OrderDoneScreenState createState() => _OrderDoneScreenState();
}

class _OrderDoneScreenState extends State<OrderDoneScreen> {
  dynamic _timeCounter = 0;
  // String _parsedTime = '00:00';
  String _orderStatus = 'Preparing your order...';
  bool showTimer = false;
  bool showCancelButton = true;

  @override
  void initState() {
    getOrder();
    super.initState();
  }

  // void countTime(){
  //   Timer.periodic(new Duration(seconds: 1), (timer) {
  //     setState(() {
  //       _timeCounter++;
  //       // _parsedTime = '${(_timeCounter ~/ 60).toString().padLeft(2, '0')}:${(_timeCounter % 60).toString().padLeft(2, '0')}';
  //     });
  //   });
  // }

  getOrder(){
    Timer.periodic(new Duration(seconds: 10), (timer) {
      OrdersService().getOrder(widget.orderId).then((order) {
        if (order['status'] == 'done') {
          timer.cancel();
          setState(() {
            _orderStatus = 'Your order is ready and on it\'s way to you!';
            showTimer = false;
            showCancelButton = false;
          });
        } else if(order['status'] == 'cancelled') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCancelledScreen(orderId: order['id'], cartItemCount: widget.cartItemCount, updateCart: widget.updateCart)));
        } else if(order['status'] == 'open') {
          // countTime();
          setState(() {
            _orderStatus = 'Preparing your order...';
            showTimer = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'You successfully placed an order!',
              style: TextStyle(
                fontSize: 20,
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

            Container(
              padding: EdgeInsets.all(20),
              child: Text(_orderStatus, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
            ),

            const SizedBox(height: 15),

            // if(showTimer) Container(
            //   child: Column(
            //     children: [
            //       Text('Estimated time: ${widget.estimatedTime.toString()}', style: TextStyle(fontSize: 18)),
            //       Text('Time elapsed: $_parsedTime', style: TextStyle(fontSize: 18)),
            //     ],
            //   )
            // ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: () async {
                         final Uri url = Uri.parse(widget.invoice);
                          if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                          }
                        }, 
                        child: Text('Download invoice')
                      )
                  ),
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
                  if(showCancelButton == true) ElevatedButton(
                    onPressed: () {
                      OrdersService().cancelOrder(widget.orderId)
                      .then((value) {
                        if(value['status'] == 'cancelled'){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderCancelledScreen(orderId: value['id'], cartItemCount: widget.cartItemCount, updateCart: widget.updateCart),
                            )
                          );
                        }
                      });
                    },
                    child: Text('Cancel Order'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 0),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}