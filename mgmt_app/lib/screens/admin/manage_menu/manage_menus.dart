import 'package:flutter/material.dart';
import 'package:mgmt_app/screens/admin/manage_menu/add_menu.dart';
import 'package:mgmt_app/screens/admin/manage_menu/manage_menu.dart';
import 'package:mgmt_app/services/menu/menu.dart';

class ManageMenusScreen extends StatelessWidget {
  Future<List<dynamic>> fetchMenus() async {
    return await MenuService.getMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Menu'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMenus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
          } else if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
          } else {
        final menus = snapshot.data ?? [];
        return ListView.builder(
          itemCount: menus.length,
          itemBuilder: (context, index) {
            final menu = menus[index];
            return MenuCard(
          menu: menu,
            );
          },
        );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddMenuScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final dynamic menu;

  const MenuCard({
    required this.menu
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
      title: Text(menu['name']),
      subtitle: Text(menu['description']),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ManageMenuScreen(menuId: menu['id'])));
      },
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await MenuService.deleteMenu(menu['id']);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManageMenusScreen()));
        },
      ),
      ),
    );
  }
}