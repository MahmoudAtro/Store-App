import 'dart:convert';

import 'package:appstore/pages/shared/layout/PageLayout.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:appstore/pages/shared/widgets/ProductWidget.dart';
import 'package:appstore/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final slides = [
    {
      'title': 'Mercedes W21',
      'image':
          'https://www.kbb.com/wp-content/uploads/2022/08/2022-mercedes-amg-eqs-front-left-3qtr.jpg'
    },
    {
      'title': 'Hennessey - w12',
      'image':
          'https://imageio.forbes.com/specials-images/imageserve/6064b148afc9b47d022718d1/Hennessey-Venom-F5/960x0.jpg'
    },
    {
      'title': 'Rolls Royce W21',
      'image':
          'https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/gallery_slide/public/images/car-reviews/first-drives/legacy/rolls_royce_phantom_top_10.jpg'
    },
  ];
  List<Product>? products;
  bool isLoading = false;
  updateProductsByCategory(List<Product> netproducts) {
    setState(() {
      products = netproducts;
    });
  }

 

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return PageLayout(
      title: 'Home Page',
      updateProductsByCategory: updateProductsByCategory,
      body: Column(
        children: [
          // Expanded(
          //   flex: 3,
          //   child: _slider(),
          // ),

          // Most Selling Products
          Expanded(
            flex: 7,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    // 1) null -> error - 2) [] -> no data - 3) [...] -> showing
                    child: products == null
                        ? Text(
                            'There was an error while fetching data from server')
                        : (products!.isEmpty
                            ? Text('No Data was found to be showing')
                            : _productsWidget()),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _slider() {
    return InfiniteCarousel.builder(
        loop: false,
        itemCount: slides.length,
        itemExtent: MediaQuery.of(context).size.width - 20,
        itemBuilder: (context, index, _) {
          return Container(
            margin: const EdgeInsets.only(right: 5),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    slides[index]['image']!,
                    width: MediaQuery.of(context).size.width - 20,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(slides[index]['title']!)
              ],
            ),
          );
        });
  }

  Widget _productsWidget() {
    return GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 3.0),
      crossAxisCount: 2,
      childAspectRatio: 0.65,
      children: products!
          .map(
            (el) => ProductWidget(product: el),
          )
          .toList(),
    );
  }

  Future<void> _init() async {
    // show loading
    setState(() => isLoading = true);

    // calling the api
    products = await ProductService.getMostSellingProducts();
    await Future.delayed(Duration(seconds: 3));

    // hide loading
    if (mounted) setState(() => isLoading = false);
  }
}
