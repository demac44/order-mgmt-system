


import 'package:flutter/material.dart';
import 'package:mgmt_app/services/users.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<dynamic> _users = [];

  @override
  void initState(){
    super.initState();
    getUsers();
  }

  Future<List<dynamic>> getUsers(){
    dynamic users = UsersService().getUsers();
    setState(() {
      _users = users;
    });

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: Container(
        // Add your widget tree here
      ),
    );
  }
}