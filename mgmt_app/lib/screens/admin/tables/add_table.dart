import 'package:flutter/material.dart';
import 'package:mgmt_app/services/tables.dart';

class AddTableScreen extends StatefulWidget {
  final Function() refreshTables;

  AddTableScreen({required this.refreshTables});

  @override
  _AddTableScreenState createState() => _AddTableScreenState();
}

class _AddTableScreenState extends State<AddTableScreen> {
  String _tableNumber = '';


  add(){
    TablesService().createTable(_tableNumber).then((value) {
      widget.refreshTables();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Table'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Table Number',
              ),
              onChanged: (value) => 
                setState(() => _tableNumber = value),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                add();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}