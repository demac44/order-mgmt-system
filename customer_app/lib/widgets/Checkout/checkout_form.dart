
import 'package:customer_app/config/config.dart';
import 'package:customer_app/screens/order_done/index.dart';
import 'package:customer_app/services/cart.dart';
import 'package:customer_app/services/orders.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:flutter_stripe/flutter_stripe.dart'; 
import 'package:http/http.dart' as http; 

class CheckoutForm extends StatefulWidget {
  void Function() updateCart;
  final int cartItemCount;

  CheckoutForm({Key? key, required this.updateCart, required this.cartItemCount}) : super(key: key);

  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  List<dynamic> _cartItems = [];
  double _total = 0;
  Map<String, dynamic>? paymentIntent;
  String tableNumber = '';
  bool _tableNumberCorrect = true;


  @override
  void initState() {
    super.initState();
    getCartItems();
  }

  Future<List<dynamic>> getCartItems() async {
    var items = await CartService().getCart();
    var total = CartService().getTotalPrice(items);

    setState(() {
      _cartItems = items;
      _total = total;
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter number of the table',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15, right: 15)
                ),
                onChanged: (value){
                  setState(() {
                    tableNumber = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 5),
            if(!_tableNumberCorrect) Text('Wrong table number', style: TextStyle(color: Colors.red, fontSize: 16)),
            const SizedBox(height: 5),

            ElevatedButton(
            onPressed: () async {
                  await OrdersService().checkTableNumber(tableNumber).then((value) async {
                  if(value?['id'] != null){
                    setState(() {
                      _tableNumberCorrect = true;
                    });
                    await makePayment((_total * 100).toInt().toString());
                  } else {
                    setState(() {
                      _tableNumberCorrect = false;
                    });
                    return null;
                  }
                });
            }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: tableNumber.isEmpty ? Colors.grey : Colors.lightBlue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 0),
              padding: const EdgeInsets.all(10),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: const Text('Pay with card', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () async { 
                  await OrdersService().checkTableNumber(tableNumber).then((value) {
                  if(value?['id'] != null){
                    setState(() {
                      _tableNumberCorrect = true;
                    });
                    makeOrder(null); 
                  } else {
                    setState(() {
                      _tableNumberCorrect = false;
                    });
                    return null;
                  }
                });
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: tableNumber.isEmpty ? Colors.grey : Colors.lightBlue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 0),
                padding: const EdgeInsets.all(10),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Pay with cash', style: TextStyle(color: Colors.white)),
            ),
        ]
    );
  }

  Future<void> makePayment(String total) async { 
    try { 
      paymentIntent = await createPaymentIntent(total, 'EUR'); 
      await Stripe.instance.initPaymentSheet( 
        paymentSheetParameters: SetupPaymentSheetParameters( 
        paymentIntentClientSecret: paymentIntent!['client_secret'], 
        googlePay: const PaymentSheetGooglePay( 
          testEnv: true, 
          currencyCode: "EUR", 
          merchantCountryCode: "DE"), 
        allowsDelayedPaymentMethods: true,
        merchantDisplayName: 'Demac',
        customerId: null
        ), 
      ); 
      displayPaymentSheet(); 
    } catch (e) { 
      print("exception $e"); 

      if (e is StripeConfigException) { 
        print("Stripe exception ${e.message}"); 
      } else { 
        print("exception $e"); 
      } 
    } 
  } 


  makeOrder(dynamic pi) async {
      await OrdersService().createOrder(tableNumber, pi).then((value) async {
        await CartService().clearCart().then((value) => widget.updateCart());
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          OrderDoneScreen(
            cartItemCount: widget.cartItemCount, 
            updateCart: widget.updateCart, 
            orderId: value['order']['id'],
            estimatedTime: value?['estimatedTime'] ?? 10,
            invoice: value['invoice'],
            )
      ));
    });
  }

  displayPaymentSheet() async { 
    try { 
      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar( 
        const SnackBar(content: Text("Paid successfully"))
      ); 

      var pi = await Stripe.instance.retrievePaymentIntent(paymentIntent!['client_secret']);
      await makeOrder(pi);
    
      paymentIntent = null; 

    } on StripeException catch (e) { 
        print('Error: $e'); 

        ScaffoldMessenger.of(context).showSnackBar( 
          const SnackBar(content: Text(" Payment Cancelled")), 
        ); 
    } catch (e) { 
      print("Error in displaying"); 
      print('$e'); 
    } 
  } 

  createPaymentIntent(String amount, String currency) async { 
    try { 
      Map<String, dynamic> body = { 
        'amount': amount, 
        'currency': currency, 
        'payment_method_types[]': 'card', 
      }; 

      var secretKey = String.fromEnvironment('STRIPE_SECRET_KEY');

      var response = await http.post( 
        Uri.parse('https://api.stripe.com/v1/payment_intents'), 
        headers: { 
        'Authorization': 'Bearer $secretKey', 
        'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: body, 
      ); 
      print('Payment Intent Body: ${response.body.toString()}');
    
      return jsonDecode(response.body.toString()); 
    } catch (err) { 
      print('Error charging user: ${err.toString()}'); 
    } 
  } 
} 

