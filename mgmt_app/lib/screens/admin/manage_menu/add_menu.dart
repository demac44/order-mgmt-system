import 'package:flutter/material.dart';
import 'package:mgmt_app/screens/admin/manage_menu/manage_menus.dart';
import 'package:mgmt_app/services/menu/menu.dart';

class AddMenuScreen extends StatefulWidget {
  @override
  _AddMenuScreenState createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  String _menuName = '';
  String _menuDescription = '';

  void _saveMenu() async {
    await MenuService.addMenu(_menuName, _menuDescription, '');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManageMenusScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Menu'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Menu Name',
              ),
              onChanged: (value) {
                setState(() {
                  _menuName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Menu Description',
              ),
              onChanged: (value) {
                setState(() {
                  _menuDescription = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue)
                ),
                onPressed: _saveMenu,
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}