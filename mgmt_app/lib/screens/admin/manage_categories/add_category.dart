import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mgmt_app/services/categories/categories.dart';
import 'package:mgmt_app/services/cloudinary/cloudinary.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  
  late File? image = null;

  add() async {
    var i = await CloudinaryService.upload(image, 'final-project/categories');
    var name = _nameController.text;
    var description = _descriptionController.text;

    CategoriesService.addCategory(name, description, i).then((value) {
      Navigator.popAndPushNamed(context, '/manage-categories');
    });
  }


  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: 
      SingleChildScrollView(
        child:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
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
            const SizedBox(height: 16.0),
            if(image != null) ...[
              MaterialButton(onPressed: () {
                setState(() {
                  image = null;
                });
              }, child: const Text('Remove Image')),
              Image.file(image!),
            ],
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                add();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
      )
    );
  }
}

