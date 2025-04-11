import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  Product(this.name, this.price);
}

class ProductViewModel extends ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    // altera para está carregando e notifica os ouvintes
    isLoading = true;
    notifyListeners();

    // antes de entrar aqui abaixo que vai demorar para exibir a tela
    await Future.delayed(const Duration(seconds: 2));
    products = [
      Product('Product 1', 10.0),
      Product('Product 2', 20.0),
      Product('Product 3', 30.0),
    ];
    isLoading = false;
    notifyListeners();
  }
}

//!  Como levará um tempo para processar e exibir na tela, para o usuario
//!  não ficar sem saber o que está ocorrendo
//! é exibida uma mensagem de loading, e quando o processo terminar
//! será exibido o resultado, isso usando os listeners
void main() async {
  ProductViewModel productViewModel = ProductViewModel();

  productViewModel.addListener(() {
    if (productViewModel.isLoading) {
      print('Objects Loading....');
    } else {
      print('Product length: ${productViewModel.products.length}');
    }
  });
  await productViewModel.fetchProducts();
}
