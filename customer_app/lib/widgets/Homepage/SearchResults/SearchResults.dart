import 'package:customer_app/widgets/Homepage/Products/products.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  final void Function() updateCart;
  final int cartItemCount;
  final List<dynamic> searchResults;

  SearchResults({required this.updateCart, required this.cartItemCount, required this.searchResults});

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height -275,
      child: Expanded(
        child: Products(updateCart: widget.updateCart, cartItemCount:widget.cartItemCount, products: widget.searchResults)
      )
    );
  }
}