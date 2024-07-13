import 'package:flutter/material.dart';
import 'package:mgmt_app/screens/admin/manage_menu/add_menu_item.dart';
import 'package:mgmt_app/screens/admin/manage_menu/edit_menu_item.dart';
import 'package:mgmt_app/services/menu/menu.dart';

class ManageMenuScreen extends StatefulWidget {
  final int menuId;

  ManageMenuScreen({required this.menuId});

  @override
  _ManageMenuScreenState createState() => _ManageMenuScreenState();
}

class _ManageMenuScreenState extends State<ManageMenuScreen> {
  late dynamic _menu = {};

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  Future<dynamic> fetchMenu() async {
    var m = await MenuService.getMenu(widget.menuId);
    setState(() {
      _menu = m;
    });
    return m;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_menu['name'] ?? 'Menu'),
      ),
      body: ListView.builder(
          itemCount: _menu?['items']?.length ?? 0,
          itemBuilder: (context, index) {
          final menuItem = _menu['items'][index];
          return MenuItem(
              name: menuItem['name'],
              image: menuItem['images'][0]['image'],
              price: menuItem['price'],
              quantity: menuItem['quantity'],
              onDelete: () {
                MenuService.deleteMenuItem(menuItem['id'])
                .then((res) {
                  fetchMenu();
                });
              },
              onEdit: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditMenuItemScreen(item: menuItem, menuId: widget.menuId,)));
              },
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMenuItemScreen(menuId: _menu['id'] ?? 0)),
          );
        },
      ),
    );
  }
}


class MenuItem extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final int quantity;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const MenuItem({
    required this.name,
    required this.image,
    required this.onDelete,
    required this.onEdit,
    required this.price,
    required this.quantity
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.network(image),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(name, style: TextStyle(fontSize: 18)),
                Text('Price: JOD $price', style: TextStyle(fontSize: 14)),
                Text('Qty: $quantity', style: TextStyle(fontSize: 14)),
              ],
            )
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