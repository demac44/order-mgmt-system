
import 'package:customer_app/services/cart.dart';
import 'package:customer_app/services/menu.dart';
import 'package:customer_app/widgets/Header/header.dart';
import 'package:customer_app/widgets/Homepage/Products/products_horizontal.dart';
import 'package:customer_app/widgets/Homepage/Products/sides_products.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  final void Function() updateCart;
  final int cartItemCount;

  const ProductScreen({Key? key, required this.productId, required this.updateCart, required this.cartItemCount});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int get productId => widget.productId;
  dynamic product;

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  getProduct() async {
    return await MenuService.getMenuItem(productId).then((value) {
      setState(() {
        product = value;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Header(cartItemCount: widget.cartItemCount, updateCart: widget.updateCart),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product?['images']?[0]?['image'] ?? 'https://via.placeholder.com/150',),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?['name'] ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'JOD ${product?['price'] ?? 0.0}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.deepOrange),
                        ),
                        onPressed: () {
                          CartService().addToCart({
                            'name': product['name'],
                            'price': double.parse(product['price']),
                            'imageUrl': product['images'][0]['image'],
                            'productId': product['id'],
                            'id': product['id'],
                          }).then((value) {
                            widget.updateCart();
                          });
                        },
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product?['description'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Sides',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              // height: MediaQuery.of(context).size.height,
              child: SidesProducts(
                cartItemCount: widget.cartItemCount,
                updateCart: widget.updateCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}