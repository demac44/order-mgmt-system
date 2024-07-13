import 'package:customer_app/services/menu.dart';
import 'package:customer_app/widgets/Header/header.dart';
import 'package:customer_app/widgets/Homepage/Products/products.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  final Map<String, dynamic> filters;
  final int cartItemCount;
  final void Function() updateCart;

  const ProductsPage({Key? key, required this.filters, required this.cartItemCount, required this.updateCart}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late List<dynamic> _products = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<List<dynamic>> getProducts() async {
    return MenuService.getMenuItems(widget.filters).then((products) {
      print(products);
      setState(() {
        _products = products;
      });
      return products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(cartItemCount: widget.cartItemCount, updateCart: widget.updateCart),
    body: _products.isNotEmpty ? Products(updateCart: widget.updateCart, cartItemCount: widget.cartItemCount, products: _products) : CircularProgressIndicator()
    );
  }
}