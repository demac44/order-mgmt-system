


import 'package:flutter/material.dart';
import 'package:mgmt_app/services/tables.dart';

class EditTableScreen extends StatefulWidget {
  final dynamic table;
  final Function() refreshTables;

  EditTableScreen({required this.table, required this.refreshTables});

  @override
  _EditTableScreenState createState() => _EditTableScreenState();
}

class _EditTableScreenState extends State<EditTableScreen> {
  String tableNumber = '';

  @override
  void initState() {
    super.initState();
    tableNumber = widget.table['code'];
  }

  edit(){
    TablesService().updateTable(widget.table['id'], tableNumber).then((value) {
      widget.refreshTables();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Table'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Table Number',
              ),
              onChanged: (value) {
                setState(() {
                  tableNumber = value.toString();
                });
              },
              controller: TextEditingController(text: tableNumber),
            ),
            SizedBox(height: 16.0),
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