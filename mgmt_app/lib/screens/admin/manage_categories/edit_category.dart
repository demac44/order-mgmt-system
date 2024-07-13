import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mgmt_app/screens/admin/manage_categories/manage_categories.dart';
import 'package:mgmt_app/services/categories/categories.dart';
import 'package:mgmt_app/services/cloudinary/cloudinary.dart';

class EditCategoryScreen extends StatefulWidget {
  String categoryName;
  String description;
  String imageUrl;
  int id;

  EditCategoryScreen({
    required this.categoryName,
    required this.description,
    required this.imageUrl,
    required this.id,
  });

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  late File? file = null;
  String name = '';
  String description = '';
  int id = 0;

  @override
  void initState() {
    super.initState();
    name = widget.categoryName;
    description = widget.description;
    id = widget.id;
  }


  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);

      setState(() => this.file = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  edit() async {
    dynamic image = file;

    if(image != null) {
      image = await CloudinaryService.upload(image, 'final-project/categories');
    } else {
      image = widget.imageUrl;
    }

    return await CategoriesService.updateCategory(id, name, description, image)
    .then((value) {
      Navigator.popAndPushNamed(context, '/manage-categories');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Category'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.categoryName,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Category Name',
              ),
            ),
            TextFormField(
              initialValue: widget.description,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            MaterialButton(
                color: Colors.blue,
                child: const Text(
                    "Pick Image from Gallery",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                  pickImage();
                }
            ),  
            SizedBox(height: 20),
            Image.network(
              widget.imageUrl,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                edit();
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}