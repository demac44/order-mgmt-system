import 'package:flutter/material.dart';
import 'package:mgmt_app/services/orders/cashier_orders.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminOrderWidget extends StatefulWidget {
  final dynamic order;
  final Function getOrders;

  const AdminOrderWidget({Key? key, required this.order, required this.getOrders}) : super(key: key);

  @override
  _AdminOrderWidgetState createState() => _AdminOrderWidgetState();
}

class _AdminOrderWidgetState extends State<AdminOrderWidget> {
  bool _showDetails = false;
  dynamic order;

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), 
        borderRadius: BorderRadius.circular(20),    
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showDetails = !_showDetails;
              });
            },
            child: ListTile(
              title: Text(order?['orderNumber']),
              subtitle: Text('Status: ${status[order['status']]}'),
              trailing: const Icon(Icons.arrow_forward_ios)
            )
          ),
          if (_showDetails)
            Column(
              children: [

                if(order?['items'] != null) ...order['items'].map((item) => 
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${item['quantity']} x ${item['menuItem']['name']}', style: const TextStyle(fontSize: 17)),
                        Text('JOD ${item['total_price']}', style: const TextStyle(fontSize: 17))
                  ],
                  )
                )  ).toList(),

                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total: ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      Text('JOD ${order['total']}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(order['invoice']);
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                  },
                  child: const Text('Download Invoice'),
                )
              ],
            ),
        ],
      ),
    );
  }


  Map<String, String> status = {
    'open': 'Open',
    'cancelled': "Cancelled",
    "done": "Done"
  };
}