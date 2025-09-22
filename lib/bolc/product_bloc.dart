import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/bolc/prodcut_event.dart';
import 'package:flutterbloc/bolc/product_state.dart';
import 'package:flutterbloc/models/product_model.dart';

class ProductBloc extends Bloc<ProdcutEvent, ProductState> {
  final List<ProductModel> _products = [];

  ProductBloc() : super(ProductInitial()) {
    on<LoadProduct>(_onLoadProducts);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onLoadProducts(
    LoadProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    await Future.delayed(Duration(milliseconds: 500));
    emit(ProductLoaded(List.from(_products)));
  }

  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    await Future.delayed(Duration(milliseconds: 500));
    final newProduct = event.prodcut.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _products.add(newProduct);
    emit(ProductOperationSuccess('Product added successfully!'));
    emit(ProductLoaded(List.from(_products)));
  }

  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    await Future.delayed(Duration(milliseconds: 500));
    final index = _products.indexWhere((p) => p.id == event.product.id);
    if (index != -1) {
      _products[index] = event.product;
      emit(ProductOperationSuccess('Product updated successfully!'));
      emit(ProductLoaded(List.from(_products)));
    } else {
      emit(ProductError('Product not found'));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    await Future.delayed(Duration(milliseconds: 500));
    _products.removeWhere((p) => p.id == event.productId);
    emit(ProductOperationSuccess('Product deleted successfully!'));
    emit(ProductLoaded(List.from(_products)));
  }
}
