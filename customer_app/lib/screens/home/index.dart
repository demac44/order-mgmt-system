import "package:customer_app/services/menu.dart";
import 'package:customer_app/widgets/Homepage/Products/products.dart';
import "package:customer_app/widgets/Homepage/SearchResults/SearchResults.dart";
import 'package:flutter/material.dart';
import "../../../widgets/Header/header.dart";
import "../../../widgets/Homepage/search.dart";
import "../../../widgets/Homepage/Categories/categories.dart";

class HomePage extends StatefulWidget {
  int cartItemCount;
  final void Function() updateCart;

  HomePage({required this.cartItemCount, required this.updateCart});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _products = [];
  List<dynamic> _searchResults= [];
  String _query = '';
  
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<List<dynamic>> getProducts() async {
    var products = await MenuService.getPopularItems();
    setState(() {
      _products = products;
    });
    return products;
  }

  Future<List<dynamic>> searchProducts(String search) async {
    var results = await MenuService.getMenuItems({ 'search': search.isEmpty ? null : search });
    setState(() {
      _searchResults = results;
      _query = search;
    });
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(cartItemCount: widget.cartItemCount, updateCart: widget.updateCart),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SearchWidget(searchProducts: searchProducts),
          const SizedBox(height: 10),
          if(_searchResults.length > 0 && _query.isNotEmpty) SearchResults(searchResults: _searchResults, updateCart: widget.updateCart, cartItemCount: widget.cartItemCount),
          Categories(cartItemCount: widget.cartItemCount, updateCart: widget.updateCart),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text('Popular', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child:  Products(updateCart: widget.updateCart, cartItemCount: widget.cartItemCount, products: _products)
          )
        ]
      )
    );
  }
}