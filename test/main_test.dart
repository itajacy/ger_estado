import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  Product(this.name, this.price);
}

// state pattern
// GERENCIAMENTO DE ESTADO FEITO PELA CLASSE
// com valuenotifier as propriedades devem ser imutáveis usar final
class ProductState {
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;

  ProductState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isError => errorMessage != null;

  ProductState setLoading(bool loading) {
    return ProductState(
      products: products,
      isLoading: loading,
      errorMessage: null,
    );
  }

  ProductState setError(String message) {
    return ProductState(products: [], isLoading: false, errorMessage: message);
  }

  ProductState setProducts(List<Product> newProducts) {
    return ProductState(
      products: newProducts,
      isLoading: false,
      errorMessage: null,
    );
  }
}

// PROPAGAÇÃO DO ESTADO
//  Imutabilidade com gerenciamento de estado
class ProductViewModel extends ValueNotifier<ProductState> {
  ProductViewModel() : super(ProductState());

  Future<void> fetchProducts({required bool isError}) async {
    // Reset state

    value = value.setLoading(true);

    // antes de entrar aqui abaixo que vai demorar para exibir a tela
    // simulando uma demora de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // tratativa  em caso de erro
    if (isError) {
      value = value.setError('Error fetching products');

      return;
    }

    // tratativa  em caso de sucesso
    value = value.setProducts([
      Product('Product 1', 10.0),
      Product('Product 2', 20.0),
      Product('Product 3', 30.0),
    ]);
  }
}

//!  Como levará um tempo para processar e exibir na tela, para o usuario
//!  não ficar sem saber o que está ocorrendo
//! é exibida uma mensagem de loading, e quando o processo terminar
//! será exibido o resultado, isso usando os listeners
void main() async {
  ProductViewModel productViewModel = ProductViewModel();

  productViewModel.addListener(() {
    final state = productViewModel.value;
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
