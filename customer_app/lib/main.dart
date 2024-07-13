import 'package:customer_app/config/config.dart';
import 'package:customer_app/screens/product/index.dart';
import 'package:flutter/material.dart';
import 'screens/home/index.dart';
import 'screens/cart/index.dart';
import "services/cart.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized(); 
  Stripe.publishableKey = String.fromEnvironment('STRIPE_PUBLISHABLE_KEY'); 
  Stripe.stripeAccountId = String.fromEnvironment('STRIPE_ACCOUNT_ID');
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int cartItemCount = 0;

  void updateCart() {
    CartService().getCartItemCount().then((value) {
      setState(() {
        cartItemCount = value;
      });
    });
  }

  @override
  void initState() {
      super.initState();
      createCart(); 
      updateCart();
  }

  createCart() async {
    return CartService().createCart();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false ,
      home: HomePage(cartItemCount: cartItemCount, updateCart: updateCart),
      routes: {
        '/cart': (context) => Cart(cartItemCount: cartItemCount, updateCart: updateCart)
      },
    );
  }
}