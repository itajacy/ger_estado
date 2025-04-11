import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  Product(this.name, this.price);
}

class ProductViewModel extends ChangeNotifier {
  List<Product> products = [];

  Future<void> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    products = [
      Product('Product 1', 10.0),
      Product('Product 2', 20.0),
      Product('Product 3', 30.0),
    ];
    notifyListeners();
  }
}

void main() async {
  ProductViewModel productViewModel = ProductViewModel();
  productViewModel.addListener(() {
    print('Product length: ${productViewModel.products.length}');
  });
  await productViewModel.fetchProducts();
}
