import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mgmt_app/screens/admin/manage_menu/manage_menu.dart';
import 'package:mgmt_app/services/categories/categories.dart';
import 'package:mgmt_app/services/cloudinary/cloudinary.dart';
import 'package:mgmt_app/services/menu/menu.dart';

class EditMenuItemScreen extends StatefulWidget {
  final dynamic item;
  final int menuId;

  EditMenuItemScreen({required this.item, required this.menuId});

  @override
  _EditMenuItemScreenState createState() => _EditMenuItemScreenState();
  
}

class _EditMenuItemScreenState extends State<EditMenuItemScreen> {

  String _name = '';
  String _description = '';
  String _price = '0.0';
  dynamic _selectedCategory = '';
  int _quantity = 0;
  List<dynamic> images = [];
  List<dynamic> categories = [];
  bool isSide = false;

  late List<File?> _images = [];

  initState() {
    super.initState();
    getCategories();
      _name = widget.item['name'];
      _description = widget.item['description'];
      _price = widget.item['price'];
      _selectedCategory = widget.item['category']['id'];
      _quantity = widget.item['quantity'];
      images = widget.item['images'];
      isSide = widget.item['isSide'];
  }

  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if(images == null) return;
      // final imageTemps = File(image.path);

      List<File?> imagesTemp = images.map((image) => File(image.path)).toList();

      setState(() => this._images = imagesTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<List<dynamic>> getCategories() async {
    var categ = await CategoriesService.getCategories();

    setState(() {
      categories = categ;
    });

    return categ;
  }

  add() async {
    List uploadedImages = [];
    for(var image in _images) {
      uploadedImages.add({
        'image': await CloudinaryService.upload(image, 'final-project/menu_items'),
        "isMain": false
      });
    }

    await MenuService.edit(widget.item['id'], _name, _description, _price, _quantity, _selectedCategory, uploadedImages, isSide)
    .then((res){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManageMenuScreen(menuId: widget.menuId)));
    });  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
              decoration:  const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                setState(() {
                _name = value;
                });
              },
              controller: TextEditingController(text: _name), // Add default value
              ),
              const SizedBox(height: 16.0),
              TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                setState(() {
                _description = value;
                });
              },
              controller: TextEditingController(text: _description), // Add default value
              ),
              const SizedBox(height: 16.0),
              TextField(
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  _price = value.toString();
                });
              },
              controller: TextEditingController(text: _price.toString()), // Add default value
              ),
              TextField(
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                _quantity = int.parse(value);
                });
              },
              controller: TextEditingController(text: _quantity.toString()), // Add default value
              ),
              const SizedBox(height: 16.0),
              if(categories.length > 0) DropdownButtonFormField<dynamic>(
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              value: _selectedCategory.toString(),
              items: categories.map((category) {
                return DropdownMenuItem(
                value: category['id'].toString(),
                child: Text(category['name']),
                key: Key('category_${category['id']}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                _selectedCategory = int.parse(value.toString());
                });
              },
              ),
              const SizedBox(height: 16.0),
                Row(
                children: [
                  Text('Is Side Meal/Drink:', style: TextStyle(fontSize: 18)),
                  Radio(
                    value: true,
                    groupValue: isSide,
                    onChanged: (value) {
                      setState(() {
                      isSide = value ?? false;
                      });
                    },
                  ),
                  Text('Yes'),
                  Radio(
                    value: false,
                    groupValue: isSide,
                    onChanged: (value) {
                      setState(() {
                      isSide = value ?? false;
                      });
                    },
                  ),
                  Text('No'),
                ],
                ),
              if(images.length > 0) Row(
              children: images.map((image) {
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: EdgeInsets.all(8),
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(right: 16.0),
                    child: Image.network(image['image'], fit: BoxFit.cover, width: 80, height: 80,)
                  ),
                  onTap: () {
                    setState(() {
                    images.remove(image);
                    });
                  },
                );
              }).toList(),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
              onPressed: () {
                pickImages();
              },
              child: const Text('Add Images'),
              ),
              const SizedBox(height: 16.0),
              if(_images.length > 0 && _images != null) Row(
              children: _images.map((image) {
                return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  padding: EdgeInsets.all(8),
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 16.0),
                  child: Image.file(image!)
                ),
                onTap: () {
                  setState(() {
                  _images.remove(image);
                  });
                },
                );
              }).toList(),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
              onPressed: () {
                add();
              },
              child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}