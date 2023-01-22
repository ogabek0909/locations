import 'package:flutter/material.dart';
import 'package:locations/providers/auth.dart';
import 'package:locations/providers/products.dart';
import 'package:locations/screens/add_product_screen.dart';
import 'package:locations/screens/auth_screen.dart';
import 'package:locations/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthScreen(),
        routes: {
          AddProductScreen.routeName: (context) => const AddProductScreen()
        },
      ),
    );
  }
}
