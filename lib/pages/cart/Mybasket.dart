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
        // products = context.watch<Model>().getAllProdectMyBasket();
      }
    }
  }

  updateCart() async {
    // final res = await http.put(Uri.parse('https://dummyjson.com/carts/1'));
    // if (res.statusCode == 200) {
    //   // final productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
    //   // if (productResponse.products.isNotEmpty) {
    //   //   // products = context.watch<Model>().getAllProdectMyBasket();
    //   // }
    // }
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
        // context.read<Model>().getAllProdectMyBasket().map((element) async =>
        //     await Datame.insertOrder(Order(
        //         title: element.title,
        //         description: element.description,
        //         price: element.price,
        //         image: element.images.first)));
        context.read<Model>().removeAllProduct();
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            btnOkOnPress: () {},
            title: 'The order has been deleted successfully')
          ..show();
        Future.delayed(Duration(milliseconds: 100));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }

  @override
  void initState() {
    products = context.read<Model>().getAllProdectMyBasket();
    getAllCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
        child: Text("Buy"),
      ),
      appBar: AppBar(
        title: Text("My Basket"),
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
                      color: const Color.fromARGB(255, 255, 82, 82),
                    )),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent),
                      child: Text(
                        "${provider.count()}",
                        style: TextStyle(color: Colors.white),
                      )))
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
                    child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(provider
                        .getAllProdectMyBasket()[index]
                        .images
                        .first
                        .toString()),
                  ),
                  title:
                      Text("${provider.getAllProdectMyBasket()[index].title}"),
                  subtitle: Text(
                      "${provider.getAllProdectMyBasket()[index].price.toStringAsFixed(2)}\$"),
                  trailing: SizedBox(
                    width: 120,
                    child: IconButton(
                        onPressed: () {
                          updateCart();
                          provider.removeProduct(
                              provider.getAllProdectMyBasket()[index]);
                        },
                        icon: Icon(Icons.remove)),
                  ),
                ));
              })),
    );
  }
}
