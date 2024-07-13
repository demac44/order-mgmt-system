import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function searchProducts;

  SearchWidget({required this.searchProducts});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
              onChanged: (value){
                searchProducts(value);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search action here
            },
          ),
        ],
      ),
    );
  }
}