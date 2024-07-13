import 'package:flutter/material.dart';
import "package:mgmt_app/screens/admin/home/admin_home.dart";
import "package:mgmt_app/screens/admin/manage_menu/manage_menu.dart";
import "package:mgmt_app/screens/admin/manage_menu/manage_menus.dart";
import "package:mgmt_app/screens/cashier/home/cashier_home.dart";
import "./screens/login/login.dart";

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/choose_login': (context) => LoginScreen(),
        '/admin_home': (context) => AdminHomeScreen(),
        '/cashier_home': (context) => CashierHomeScreen(),
        "/manage_menus": (context) => ManageMenusScreen(),
      }
    );
  }
}