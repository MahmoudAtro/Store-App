import 'dart:convert';

import 'package:appstore/services/api.dart';

import '../pages/shared/models/products_response.dart';


class ProductService {
  ///
  /// This method is used to get most selling 10 product
  /// [return] list of product objects
  ///
  static Future<List<Product>?> getMostSellingProducts() async {
    List<Product>? products;
    final res = await Api.get('products', {
      'limit': '10',
    });
    if (res.statusCode == 200) {
      final productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
      if (productResponse.products.isNotEmpty) {
        products = productResponse.products; //.getRange(0, 10).toList();
      }
    }
    return products;
  }

  ///
  /// This method is used to get all product
  /// [return] list of product objects
  /// [todo] add pagination to this method
  ///
  static Future<List<Product>?> getProducts() async {
    List<Product>? products;
    final res = await Api.get('products');
    if (res.statusCode == 200) {
      final productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
      if (productResponse.products.isNotEmpty) {
        products = productResponse.products;
      }
    }
    return products;
  }
}
