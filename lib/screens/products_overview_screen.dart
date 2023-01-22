import 'package:flutter/material.dart';
import 'package:locations/providers/products.dart';
import 'package:locations/screens/add_product_screen.dart';
import 'package:provider/provider.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Products>(context,listen: false).fetchProducts().then((value) {
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: products.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) =>  ListTile(
                title: Text(products[i].name),
              ),
            ),
    );
  }
}
