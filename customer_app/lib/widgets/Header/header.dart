import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget implements PreferredSizeWidget {
  int cartItemCount;
  void Function() updateCart;

  Header({super.key, required this.cartItemCount, required this.updateCart});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png', // Replace with your logo image path
            height: 30,
          ),
          const SizedBox(width: 10),
          const Text(
            'Restaurant',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Text(
                    '${cartItemCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            // Navigate to cart screen
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

