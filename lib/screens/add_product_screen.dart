import 'package:flutter/material.dart';
import 'package:locations/models/product.dart';
import 'package:locations/providers/products.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Product? _product;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    print('works');
    // _formKey.currentState!.save();
    // print(_nameController.text);
    _product = Product(name: _nameController.text, price: double.parse(_priceController.text));
    await Provider.of<Products>(context, listen: false).addProduct(_product!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        actions: [IconButton(onPressed: _submit, icon: const Icon(Icons.save))],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please write something!';
                        }
                        return null;
                      },
                      // onSaved: (newValue) {
                      //   _product = Product(name: newValue!, price: null);
                      // },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _priceController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please write something!';
                        }
                        return null;
                      },
                      
                      onFieldSubmitted: (value) => _submit(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Price',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
