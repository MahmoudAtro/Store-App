import 'package:appstore/pages/shared/models/DatabaseLocal.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OrderPage> {
  List order = [];
  Future getAllOrder() async {
    final orederget = await Datame.getAllOrder();
    return orederget;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              title: Text(
                "Order Page",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            body: Container(
              width: double.infinity,
              color: Colors.grey[200],
              padding: EdgeInsets.all(10),
              child: FutureBuilder(
                future: getAllOrder(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'an error occurred ${snapshot.error.toString()}'));
                  }

                  order = snapshot.data ?? [];

                  return ListView.builder(
                  
                    itemCount: order.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(order[index]['image']),
                          ),
                          title: Text("${order[index]['title']}"),
                          subtitle: Text("${order[index]['price']}\$"),
                        ),
                      );
                    },
                  );
                },
              ),
            )));
  }
}
