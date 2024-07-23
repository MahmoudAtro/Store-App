import 'package:appstore/pages/shared/models/DatabaseLocal.dart';
import 'package:appstore/pages/shared/models/Order.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OrderPage> {
  List<Order> order = [];
  getAllOrder() async {
    final orderme = await Datame.getAllOrder();
    order = orderme;
  }

  @override
  void initState() {
    getAllOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: order.length,
        itemBuilder: (context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(order[index].image),
              ),
              title: Text("${order[index].title}"),
              subtitle: Text("${order[index].image}\$}"),
            ),
          );
        });
  }
}
