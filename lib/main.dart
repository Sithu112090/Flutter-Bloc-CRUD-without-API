import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/bolc/prodcut_event.dart';
import 'package:flutterbloc/bolc/product_bloc.dart';
import 'package:flutterbloc/screens/prodcut_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc()..add(LoadProduct())),
      ],
      child: MaterialApp(
        title: 'Bloc',
        debugShowCheckedModeBanner: false,
        home: ProdcutListScreen(),
      ),
    );
  }
}
