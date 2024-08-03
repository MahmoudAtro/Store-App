import 'dart:convert';

import 'package:appstore/pages/home/home_page.dart';
import 'package:appstore/pages/shared/models/DatabaseLocal.dart';
import 'package:appstore/pages/shared/models/Order.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MyBasket extends StatefulWidget {
  const MyBasket({super.key});

  @override
  State<MyBasket> createState() => _MyBasketState();
}

class _MyBasketState extends State<MyBasket> {
  List<Product>? products;

  getAllCart() async {
    final res = await http.get(Uri.parse('https://dummyjson.com/carts/add'));
    if (res.statusCode == 200) {
      final productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
      if (productResponse.products.isNotEmpty) {
        products = context.watch<Model>().getAllProdectMyBasket();
      }
    }
  }

  updateCart(int index) async {
    final res = await http.put(Uri.parse('https://dummyjson.com/carts/1'));
    if (res.statusCode == 200) {
      final productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
      if (productResponse.products.isNotEmpty) {
        // context
        //     .read()
        //     .removeProduct(context.read().getAllProdectMyBasket()[index]);
      }
    }
  }

  Future<void> insertAllOrders() async {
    var products = context.read<Model>().getAllProdectMyBasket();
    var productList = List.from(products); // إنشاء نسخة من القائمة

    for (final element in productList) {
      await Datame.insertOrder(Order(
        title: element.title,
        description: element.description,
        price: element.price,
        image: element.images.first,
      ));
    }
  }

  deletedCart() async {
    final res = await http.delete(Uri.parse('https://dummyjson.com/carts/1'));
    if (res.statusCode == 200) {
      if (context.read<Model>().count() == 0) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            btnOkOnPress: () {},
            title: 'The basket is empty')
          ..show();
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            btnOkOnPress: () {},
            title: 'The order has been deleted successfully')
          ..show();
        insertAllOrders();
        context.read<Model>().removeAllProduct();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }

  @override
  void initState() {
    getAllCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          if (provider.count() == 0) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              title: 'The basket is empty',
              desc: 'Please add a product to the cart',
              btnOkOnPress: () {},
            )..show();
          } else {
            AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                btnOkOnPress: () {},
                title: 'Purchase completed successfully')
              ..show();
            await deletedCart();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        child: Text(
          "Buy",
          style: TextStyle(color: Colors.white),
        ),
      ),
      appBar: AppBar(
        title: Text("My Basket", style: TextStyle(color: Colors.redAccent)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  deletedCart();
                },
                icon: Icon(
                  Icons.delete_forever,
                  size: 25,
                  color: Colors.red,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text("${provider.totlePrice().toStringAsFixed(2)}"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.redAccent,
                    )),
              ),
              Visibility(
                visible: provider.count() > 0,
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.redAccent),
                      child: Text(
                        "${provider.count()}",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ]),
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
              itemCount: provider.count(),
              itemBuilder: (context, int index) {
                return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(provider
                            .getAllProdectMyBasket()[index]
                            .images
                            .first
                            .toString()),
                      ),
                      title: Text(
                          "${provider.getAllProdectMyBasket()[index].title}"),
                      subtitle: Text(
                          "${provider.getAllProdectMyBasket()[index].price.toStringAsFixed(2)}\$"),
                      trailing: SizedBox(
                        width: 50,
                        child: IconButton(
                            onPressed: () {
                              provider.removeProduct(
                                  provider.getAllProdectMyBasket()[index]);
                              // updateCart(index);
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.redAccent,
                            )),
                      ),
                    ));
              })),
    );
  }
}
