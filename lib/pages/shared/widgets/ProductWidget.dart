import 'dart:convert';

import 'package:appstore/pages/auth/login.dart';
import 'package:appstore/pages/products/ProductDetailsPage.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:appstore/pages/shared/widgets/Snackbar.dart';
import 'package:appstore/services/Sherdperf.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  final bool isGrid;

  ProductWidget({
    super.key,
    required this.product,
    this.isGrid = true,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  Future<void> addToCart() async {
    final url = Uri.parse('https://dummyjson.com/carts/add');
    final response = await post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": 1,
          "products": [widget.product.toJson()]
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      
      // ShowsnackBar(context, "Cart in successfully");
    } else {
      // ShowsnackBar(
      //     context , 'Created failed. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: widget.product),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // photo
              Image.network(
                widget.product.thumbnail,
                fit: BoxFit.contain,
                height: widget.isGrid ? null : 200,
              ),

              // space
              const Spacer(),

              // title - price
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.title),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.product.price.toStringAsFixed(2)}\$',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (User.getIsLogin()) {
                            provider.addToListMyBasket(widget.product);
                            await addToCart();
                          } else {
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                btnOkText: "Login",
                                btnOkOnPress: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                btnCancelOnPress: () {},
                                title: 'Please login')
                              ..show();
                          }
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
