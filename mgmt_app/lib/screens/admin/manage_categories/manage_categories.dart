import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mgmt_app/screens/admin/manage_categories/add_category.dart';
import 'package:mgmt_app/screens/admin/manage_categories/edit_category.dart';
import 'package:mgmt_app/services/categories/categories.dart';

class ManageCategoriesScreen extends StatefulWidget {
  @override
  _ManageCategoriesScreenState createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen> {
  late Future<List<dynamic>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = getCategories();
  }

  Future<List<dynamic>> getCategories() async {
    dynamic categories = await CategoriesService.getCategories();
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Categories'),
      ),
      body: ListView(
        children: [
          FutureBuilder<List<dynamic>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<dynamic> categories = snapshot.data!;
                return Column(
                  children: categories.map((category) {
                    return CategoryItem(
                      image: category['image'],
                      name: category['name'],
                      onDelete: () async {
                        await CategoriesService.deleteCategory(category['id']).then((value) {
                          Navigator.popAndPushNamed(context, '/manage-categories');
                        });
                      },
                      onEdit: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return EditCategoryScreen(
                            id: category['id'],
                            categoryName: category['name'],
                            description: category['description'],
                            imageUrl: category['image'],
                          );
                        })).then((route) {
                          setState(() {
                            _categoriesFuture = getCategories();
                          });
                        });
                      },
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCategoryScreen()),
          );        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CategoryItem({
    required this.name,
    required this.image,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.network(image),
              ),
              SizedBox(width: 8),
              Text(name),
            ]
          ),
          Row(
            children: [
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete),
              ),
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ],
      ));
  }
}