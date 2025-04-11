import 'package:bloc/bloc.dart';

class Product {
  String name;
  double price;
  Product(this.name, this.price);
}

// state pattern
// GERENCIAMENTO DE ESTADO FEITO PELA CLASSE
// com valuenotifier as propriedades devem ser imutáveis usar final
sealed class ProductState {
  ProductState setLoading(bool loading) {
    return LoadingProductState();
  }

  ProductState setError(String message) {
    return ErrorProductState(message);
  }

  ProductState setProducts(List<Product> newProducts) {
    return LoadedProductState(newProducts);
  }
}

class InitialProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class ErrorProductState extends ProductState {
  final String errorMessage;
  ErrorProductState(this.errorMessage);
}

class LoadedProductState extends ProductState {
  final List<Product> products;

  LoadedProductState(this.products);
}

// PROPAGAÇÃO DO ESTADO
//  Imutabilidade com gerenciamento de estado
class ProductViewModel extends Cubit<ProductState> {
  ProductViewModel() : super(InitialProductState());

  // ProductViewModel() : super(ProductState());

  Future<void> fetchProducts({required bool isError}) async {
    // Reset state
    emit(state.setLoading(true));

    // antes de entrar aqui abaixo que vai demorar para exibir a tela
    // simulando uma demora de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // tratativa  em caso de erro
    if (isError) {
      emit(state.setError('Error fetching products'));

      return;
    }

    // tratativa  em caso de sucesso
    emit(
      state.setProducts([
        Product('Product 1', 10.0),
        Product('Product 2', 20.0),
        Product('Product 3', 30.0),
      ]),
    );
  }
}

//!  Como levará um tempo para processar e exibir na tela, para o usuario
//!  não ficar sem saber o que está ocorrendo
//! é exibida uma mensagem de loading, e quando o processo terminar
//! será exibido o resultado, isso usando os listeners
void main() async {
  //*

  //   tudo abaixo são só formas diferentes de propagar o estado
  // porque o gerenciamento  ocorre nas classes
  //ChangeNotifier
  //Mobx
  //Bloc
  //Cubit
  //Asp
  //Getx
  //Riverpod
  //Provider
  //GetIt
  //Signals */

  //Propagação de estado
  ProductViewModel productViewModel = ProductViewModel();

  productViewModel.stream.listen((state) {
    // final state = productViewModel.state;
    if (state is InitialProductState) {
      print('Initial state....');
    } else if (state is LoadingProductState) {
      print(' objects loading...}');
    } else if (state is ErrorProductState) {
      print('Error: ${state.errorMessage}');
    } else if (state is LoadedProductState) {
      print('Product length: ${state.products.length}');
    }
  });
  //testando com isError =  false e true
  await productViewModel.fetchProducts(isError: true);
}
