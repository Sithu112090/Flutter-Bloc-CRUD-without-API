import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/bolc/prodcut_event.dart';
import 'package:flutterbloc/bolc/product_bloc.dart';
import 'package:flutterbloc/bolc/product_state.dart';
import 'package:flutterbloc/models/product_model.dart';
import 'package:flutterbloc/screens/product_form_screen.dart';

class ProdcutListScreen extends StatefulWidget {
  const ProdcutListScreen({super.key});

  @override
  State<ProdcutListScreen> createState() => _ProdcutListScreenState();
}

class _ProdcutListScreenState extends State<ProdcutListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<ProductBloc>(context),
                    child: ProductFormScreen(),
                  ),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is ProductLoaded) {
            return _buildProductList(state.products, context);
          } else {
            return Center(child: Text('No products available'));
          }
        },
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
      ),
    );
  }

  Widget _buildProductList(List<ProductModel> products, BuildContext context) {
    if (products.isEmpty) {
      return Center(child: Text('No products available'));
    }
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductModel product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('${product.price} Ks ~ ${product.stock} Stock'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<ProductBloc>(context),
                        child: ProductFormScreen(product: product),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  _deleteDialog(context, product);
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _deleteDialog(BuildContext context, ProductModel product) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${product.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ProductBloc>().add(DeleteProduct(product.id));
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
