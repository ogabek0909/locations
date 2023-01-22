import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<void> addProduct(Product newProduct) async {
    // Uri url = Uri(
    //   scheme: 'https',
    //   host: 'todolist-4d2fb-default-rtdb.firebaseio.com',
    //   path: 'products.json'
    // );
    Uri url = Uri.parse(
        'https://todolist-4d2fb-default-rtdb.firebaseio.com/products.json');
    http.Response response = await http.post(url,
        body: jsonEncode({
          'name': newProduct.name,
          'price': newProduct.price,
        }));
    print(response.statusCode);
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    Uri url = Uri.parse(
        'https://todolist-4d2fb-default-rtdb.firebaseio.com/products.json');

    http.Response response = await http.get(url);
    print(jsonDecode(response.body));
    Map data = jsonDecode(response.body);
    List<Product> loadedProducts = [];
    data .forEach((key, value) {
      loadedProducts.add(Product(name: value['name'],price: value['price'])); 
    });
    _items = loadedProducts;
    
    notifyListeners();
  }
}

/* https://todolist-4d2fb-default-rtdb.firebaseio.com/ */