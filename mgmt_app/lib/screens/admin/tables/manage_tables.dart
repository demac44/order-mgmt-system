import 'package:flutter/material.dart';
import 'package:mgmt_app/screens/admin/tables/add_table.dart';
import 'package:mgmt_app/screens/admin/tables/edit_table.dart';
import 'package:mgmt_app/services/tables.dart';

class ManageTablesScreen extends StatefulWidget {
  @override
  _ManageTablesScreenState createState() => _ManageTablesScreenState();
}

class _ManageTablesScreenState extends State<ManageTablesScreen> {
  List<dynamic> _tables = [];

  @override
  void initState() {
    super.initState();
    getTables();
  }

  getTables() async {
    List<dynamic> tables = await TablesService().getTables();
    print(tables);
    setState(() {
      _tables = tables;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Tables'),
      ),
      body: ListView.builder(
        itemCount: _tables.length,
        itemBuilder: (context, index) {
          return ListTile(
        leading: Text('${_tables[index]['code']}', style: TextStyle(color: Colors.black, fontSize: 18)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditTableScreen(table: _tables[index], refreshTables: getTables,)));
          },
            ),
            IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            TablesService().deleteTable(_tables[index]['id']).then((value) {
              getTables();
            });
          },
            ),
          ],
        ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTableScreen(refreshTables: getTables,)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}