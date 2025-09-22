import 'package:flutter/material.dart';
import 'package:flutterbloc/models/product_model.dart';

@immutable
abstract class ProdcutEvent {}

class LoadProduct extends ProdcutEvent {}

class AddProduct extends ProdcutEvent {
  final ProductModel prodcut;
  AddProduct(this.prodcut);
}

class UpdateProduct extends ProdcutEvent {
  final ProductModel product;
  UpdateProduct(this.product);
}

class DeleteProduct extends ProdcutEvent {
  final String productId;
  DeleteProduct(this.productId);
}
