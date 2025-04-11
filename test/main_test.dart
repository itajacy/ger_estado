import 'package:bloc/bloc.dart';

class Product {
  String name;
  double price;
  Product(this.name, this.price);
}

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

class ProductViewModel extends Cubit<ProductState> {
  ProductViewModel() : super(InitialProductState());

  Future<void> fetchProducts({required bool isError}) async {
    emit(state.setLoading(true));
    await Future.delayed(const Duration(seconds: 2));

    // tratativa  em caso de erro
    if (isError) {
      emit(state.setError('Error fetching products'));
      return;
    }

    emit(
      state.setProducts([
        Product('Product 1', 10.0),
        Product('Product 2', 20.0),
        Product('Product 3', 30.0),
      ]),
    );
  }
}

void main() async {
  ProductViewModel productViewModel = ProductViewModel();

  productViewModel.stream.listen((state) {
    print(state.runtimeType);
    if (state is InitialProductState) {
      print('Initial state....');
    } else if (state is LoadingProductState) {
      print(' objects loading...');
    } else if (state is ErrorProductState) {
      print('Error: ${state.errorMessage}');
    } else if (state is LoadedProductState) {
      print('Product length: ${state.products.length}');
    }
  });
  // alterere isError para false ou true para teste
  await productViewModel.fetchProducts(isError: true);
}
