import 'dart:convert';

import 'package:appstore/pages/cart/Mybasket.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:appstore/pages/shared/widgets/Drawer.dart';
import 'package:appstore/pages/shared/widgets/ProductWidget.dart';
import 'package:appstore/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class PageLayout extends StatefulWidget {
  final String title;
  final Widget body;

  Function? updateProductsByCategory;
  Function? getAllProducts;
  PageLayout(
      {super.key,
      required this.title,
      required this.body,
      this.getAllProducts,
      this.updateProductsByCategory});

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  bool isLoading = false;
  List category = [];
  bool notap = false;
  String? itemcategory;
  List<Product> products = [];

  getProductbyCategory(String namecategory) async {
    var response = await get(
        Uri.parse('https://dummyjson.com/products/category/${namecategory}'));
    if (response.statusCode == 200) {
      final productResponse =
          ProductsResponse.fromJson(jsonDecode(response.body));
      if (productResponse.products.isNotEmpty) {
        products = productResponse.products;
      }
    }
  }

  Future getAllCategore() async {
    var response = await Api.get('products/category-list');
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      category = list;
  
  
    }
  }

  getProductByKeyWord(BuildContext context, String keyword) async {
    final res = await get(
        Uri.parse('https://dummyjson.com/products/search?q=${keyword}'));
    if (res.statusCode == 200) {
      final productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
      if (productResponse.products.isNotEmpty) {
        // products = productResponse.products;
        // showSearch(
        //     context: context,
        //     delegate: CustomSearchDelegate(
        //         products: products, getProductByKeyWord: getProductByKeyWord));
      }
    }
  }

  @override
  void initState() {
    getAllCategore();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                products = widget.getAllProducts!();
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        products: products,
                        getProductByKeyWord: getProductByKeyWord));
              },
              icon: const Icon(Icons.search)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton(
                value: itemcategory,
                hint: Text(
                  "Chose a category",
                  style: TextStyle(fontSize: 15),
                ),
                items: category
                    .map((item) => DropdownMenuItem(
                          value: item.toString(),
                          child: Text(item.toString()),
                        ))
                    .toList(),
                onChanged: (nameCategory) async {
                  setState(() {
                    itemcategory = nameCategory.toString();
                  });
                  await getProductbyCategory(nameCategory.toString());
                  widget.updateProductsByCategory!(products);
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyBasket()));
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Color.fromARGB(255, 255, 82, 82),
                    )),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Text(
                        "${provider.count()}",
                        style: const TextStyle(color: Colors.white),
                      )))
            ]),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: widget.body,
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  static bool isloding = false;
  List<Product> products;

  final Function getProductByKeyWord;
  CustomSearchDelegate(
      {required this.getProductByKeyWord, required this.products});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Row(
        children: [
          IconButton(
              onPressed: () async {
                // getProductByKeyWord(context, query);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.redAccent,
              )),
          IconButton(
              onPressed: () {
                query = '';
              },
              icon: const Icon(
                Icons.close,
                color: Colors.redAccent,
              )),
        ],
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == " ") {
      return Container(
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return SizedBox(
                height: 300,
                child: ProductWidget(product: products[index], isGrid: false));
          },
        ),
      );
    } else {
      List<Product> listserch =
          products.where((pro) => pro.title.contains(query)).toList();
      return Container(
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemCount: listserch.length,
          itemBuilder: (context, index) {
            return SizedBox(
                height: 300,
                child: ProductWidget(product: listserch[index], isGrid: false));
          },
        ),
      );
    }
    // return Container(
    //   color: Colors.grey[200],
    //   alignment: Alignment.center,
    //   child: ListView.builder(
    //     padding: const EdgeInsets.symmetric(horizontal: 30),
    //     itemCount: products.length,
    //     itemBuilder: (context, index) {
    //       return SizedBox(
    //           height: 300,
    //           child: ProductWidget(product: products[index], isGrid: false));
    //     },
    //   ),
    // );
  }
}
