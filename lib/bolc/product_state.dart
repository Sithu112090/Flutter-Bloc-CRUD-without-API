import 'package:flutter/material.dart';
import 'package:flutterbloc/models/product_model.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String errorMessage;
  ProductError(this.errorMessage);
}

class ProductOperationSuccess extends ProductState {
  final String message;
  ProductOperationSuccess(this.message);
}
