

import 'package:flutter/material.dart';
import 'package:mgmt_app/services/orders/admin_orders.dart';
import 'package:mgmt_app/widgets/orders/admin_order.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<dynamic> _orders = [];

  @override
  void initState(){
    super.initState();
    getOrders();
  }


  getOrders() async {
      var orders = await AdminOrdersService().getOrders(null);
      setState(() {
        _orders = orders;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
              foregroundColor: WidgetStateProperty.all(Colors.white)
            ),
            onPressed: () {
              getOrders();
            },
            child: Text('Refresh Orders'),
          ),
          ),
          if(_orders.length > 0) ..._orders.map((order) => AdminOrderWidget(order: order, getOrders: getOrders))
        ],
      ),
    );
  }
}







