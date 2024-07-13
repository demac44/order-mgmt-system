import 'package:flutter/material.dart';
import 'package:mgmt_app/screens/admin/manage_menu/manage_menus.dart';
import 'package:mgmt_app/screens/admin/manage_categories/manage_categories.dart';
import 'package:mgmt_app/screens/admin/orders/orders_screen.dart';
import 'package:mgmt_app/screens/admin/tables/manage_tables.dart';
import 'package:mgmt_app/screens/admin/users/manage_users.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Admin Home'),
            ElevatedButton(onPressed: () { Navigator.popAndPushNamed(context, '/'); }, child: Text('Logout'))
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ManageButton(
              title: 'Menu',
              color: Colors.deepOrange,
              onTap: () {
                // Navigate to Manage Menu page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageMenusScreen()),
                );
              },
            ),
            ManageButton(
              title: 'Tables',
              color: Colors.black45,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageTablesScreen()),
                );
              },
            ),
            ManageButton(
              title: 'Categories',
              color: Colors.teal,
              onTap: () {
                // Navigate to Manage Categories page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageCategoriesScreen()),
                );
              },
            ),
            ManageButton(
              title: 'Orders',
              color: Colors.indigo,
              onTap: () {
                // Navigate to Manage Orders page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            ),
            // ManageButton(
            //   title: 'Users',
            //   color: Colors.green,
            //   onTap: () {
            //     // Navigate to Manage Users page
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ManageUsersScreen()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class ManageButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function() onTap;

  ManageButton({Key? key, required this.title, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        color: color,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      )
    );
  }
}