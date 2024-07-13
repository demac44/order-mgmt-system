import 'package:flutter/material.dart';
import 'package:mgmt_app/services/orders/cashier_orders.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderWidget extends StatefulWidget {
  final dynamic order;
  final Function getOrders;

  const OrderWidget({Key? key, required this.order, required this.getOrders}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _showDetails = false;
  dynamic get order => widget.order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), 
        borderRadius: BorderRadius.circular(20),    
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
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
              subtitle: Text('Status: ${status[order['status']]['text']}', style: TextStyle(color: status[order['status']]['color'], fontSize: 20)),
              trailing: Icon(Icons.arrow_forward_ios)
            )
          ),
          if (_showDetails)
            Column(
              children: [

                if(order?['items'] != null) ...order['items'].map((item) => 
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${item['quantity']} x ${item['menuItem']['name']}', style: TextStyle(fontSize: 17)),
                        Text('JOD ${item['total_price']}', style: TextStyle(fontSize: 17))
                  ],
                  )
                )  ).toList(),

                const SizedBox(height: 15),

                Container(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      Text('JOD ${order['total']}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          final url = Uri.parse(order['invoice']);
                          if(!await launchUrl(url)){
                            throw 'Could not launch $url';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 90, 90, 90),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontSize: 18)
                        ),
                        child: Text('Download Invoice'),
                      ),
                    ),
                    if(order['status']  == 'open') Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          CashierOrdersService().changeStatus(order['id'], 'done')
                          .then((value) => widget.getOrders());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontSize: 18)
                        ),
                        child: Text('Mark as Done'),
                      ),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.4,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       CashierOrdersService().changeStatus(order['id'], 'preparing')
                    //       .then((value) => widget.getOrders());
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.lightBlue,
                    //       foregroundColor: Colors.white,
                    //       textStyle: TextStyle(fontSize: 18)
                    //     ),
                    //     child: Text('Accept'),
                    //   ),
                    // ),
                    SizedBox(width: 8),
                    if(order['status'] == 'open') Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          CashierOrdersService().changeStatus(order['id'], 'cancelled')
                          .then((value) => widget.getOrders());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontSize: 18)
                        ),
                        child: Text('Cancel'),
                      ),
                    ),
                  ],
                )
              ],
            ),
        ],
      ),
    );
  }


  Map<String, dynamic> status = {
    "open": { "text": "Open", 'color': Colors.orange },
    "cancelled": { "text": "Cancelled", 'color': Colors.red },
    "done": {"text": "Done", 'color': Colors.green},
  };
}