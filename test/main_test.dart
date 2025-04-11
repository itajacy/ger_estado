import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  Product(this.name, this.price);
}

// state pattern
// GERENCIAMENTO DE ESTADO FEITO PELA CLASSE
class ProductState {
  List<Product> products = [];
  bool isLoading = false;
  String? errorMessage = null;
  bool get isError => errorMessage != null;

  void setLoading(bool loading) {
    isLoading = loading;
  }

  void setError(String message) {
    errorMessage = message;
    isLoading = false;
  }

  void setProducts(List<Product> newProducts) {
    products = newProducts;
    isLoading = false;
  }
}

// PROPAGAÇÃO DO ESTADO
// FEITO PELO CHANGENOTIFIER
class ProductViewModel extends ChangeNotifier {
  var _state = ProductState();
  ProductState get state => _state;

  Future<void> fetchProducts({required bool isError}) async {
    // altera para está carregando e notifica os ouvintes

    // Reset state
    _state = ProductState();
    _state.setLoading(true);
    notifyListeners();

    // antes de entrar aqui abaixo que vai demorar para exibir a tela
    // simulando uma demora de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // tratativa  em caso de erro
    if (isError) {
      _state.setError('Error fetching products');
      notifyListeners();
      return;
    }

    // tratativa  em caso de sucesso
    _state.setProducts([
      Product('Product 1', 10.0),
      Product('Product 2', 20.0),
      Product('Product 3', 30.0),
    ]);
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
    final state = productViewModel.state;
    if (state.isLoading) {
      print('Objects Loading....');
    } else if (state.isError) {
      print('Error: ${state.errorMessage}');
    } else {
      print('Product length: ${state.products.length}');
    }
  });
  //testando com isError =  false e true
  await productViewModel.fetchProducts(isError: false);
}
