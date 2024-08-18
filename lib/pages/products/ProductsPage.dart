import 'package:appstore/pages/shared/layout/PageLayout.dart';
import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:appstore/pages/shared/widgets/ProductWidget.dart';
import 'package:appstore/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  List<Product>? Productds = [];
  ProductsPage({super.key, this.Productds});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> products = [];
  bool isLoading = false;

  updateProductsByCategory(List<Product> netproducts) {
    setState(() {
      products = netproducts;
    });
  }

  getAllProducts() {
    return products;
  }

  @override
  void initState() {
    widget.Productds == null ? init() : products = widget.Productds!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      getAllProducts:getAllProducts,
      title: 'Products Page',
      updateProductsByCategory: updateProductsByCategory,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 300,
                    child:
                        ProductWidget(product: products[index], isGrid: false),
                  );
                },
              ),
            ),
    );
  }

  Future<void> init() async {
    // show loading
    setState(() {
      isLoading = true;
    });

    // call api

    products = ((await ProductService.getProducts()) ?? []);

    // hide loading
    if (mounted) setState(() => isLoading = false);
  }
}
