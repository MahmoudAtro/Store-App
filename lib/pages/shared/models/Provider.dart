import 'package:appstore/pages/shared/models/products_response.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Model extends ChangeNotifier {
  final List<Product> _prodects = [];
  double _totleprice = 0;
  addToListMyBasket(Product newproduct) {
    _prodects.add(newproduct);
    _totleprice += newproduct.price;
    notifyListeners();
  }

  removeProduct(Product newproduct) {
    _prodects.remove(newproduct);
    _totleprice -= newproduct.price;
    notifyListeners();
  }

  List<Product> getAllProdectMyBasket() {
    return _prodects;
  }

  removeAllProduct() {
    _prodects.clear();
    _totleprice = 0;
    notifyListeners();
  }

  totlePrice() {
    return _totleprice;
  }

  int count() {
    return _prodects.length;
  }

  
}
