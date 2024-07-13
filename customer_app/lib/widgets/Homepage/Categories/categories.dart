import 'package:customer_app/screens/products/products.dart';
import 'package:customer_app/services/categories.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  final int cartItemCount;
  final void Function() updateCart;

  const Categories({Key? key, required this.cartItemCount, required this.updateCart}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List<dynamic> _categories = [];

  @override
  void initState() {
    getCategories();
    super.initState();
  }


  Future<List<dynamic>> getCategories() async {
    var categ = await CategoriesService.getCategories();
    setState(() {
      _categories = categ;
    });
    return categ;
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        // width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ..._categories.map((category){
              return CategoryBox(text: category['name'], categId: category['id'], cartItemCount: widget.cartItemCount, updateCart: widget.updateCart, image: category['image']);
            }),
          ],
        ),
      )
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String text;
  final String image;
  final int categId;
  final int cartItemCount;
  final void Function() updateCart;

  const CategoryBox({required this.text,  required this.categId, required this.cartItemCount, required this.updateCart, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsPage(filters: { 'category': categId }, cartItemCount: cartItemCount, updateCart: updateCart,) ));
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              child: Image.network(image, fit: BoxFit.cover,),
            ),
            SizedBox(width: 10.0),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
              ),
          ),
          ],
        )
      )
    );
  }
}