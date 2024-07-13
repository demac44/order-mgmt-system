import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mgmt_app/services/orders/cashier_orders.dart';
import 'package:mgmt_app/widgets/orders/order.dart';

class CashierHomeScreen extends StatefulWidget {
  @override
  _CashierHomeScreenState createState() => _CashierHomeScreenState();
}

class _CashierHomeScreenState extends State<CashierHomeScreen> {
  List<dynamic> _orders = [];
  String? _status = null;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  getOrders() {
    setState(() {
      _loading = true;
    });
    Timer.periodic(new Duration(seconds: 5), (timer) {
      CashierOrdersService().getOrders(_status)
      .then((orders) {
        setState(() {
          _orders = orders;
          _loading = false;
        });
        return orders;
      });
    });
  }

    Future<dynamic> refreshOrders(String? status) async {
      setState(() {
        _loading = true;
      });
      return await CashierOrdersService().getOrders(status == null ? null : status)
      .then((orders) {
        setState(() {
          _orders = orders;
          _loading = false;
        });
        return orders;
      });
  }

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
      body: ListView(
        children: [
          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: Text('Cashier: Demir Umejr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
          // ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){ setState((){ _status = null; }); refreshOrders(null); },
                  child: Text('All', style: TextStyle(color: Colors.black, fontSize: 16)),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    foregroundColor: WidgetStateProperty.all(Colors.black)
                  ),
                ),
                ElevatedButton(
                  onPressed: (){ setState((){ _status = 'open'; }); refreshOrders('open'); },
                  child: Text('Open', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.orangeAccent),
                    foregroundColor: WidgetStateProperty.all(Colors.white)
                  ),
                ),
                ElevatedButton(
                  onPressed: (){ setState((){ _status = 'cancelled'; }); refreshOrders('cancelled');  },
                  child: Text('Cancelled', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    foregroundColor: WidgetStateProperty.all(Colors.white)
                  ),
                ),
                ElevatedButton(
                  onPressed: (){ setState((){ _status = 'done'; }); refreshOrders('done');  },
                  child: Text('Done', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                    foregroundColor: WidgetStateProperty.all(Colors.white)
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          if(_orders.length > 0) ..._orders.map((order) => OrderWidget(order: order, getOrders: refreshOrders)),
          if(_loading) ...[Center(child: CircularProgressIndicator())],
        ],
      ),
    );
  }
}