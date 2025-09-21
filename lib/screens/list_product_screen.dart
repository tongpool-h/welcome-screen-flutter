import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'product_detail_screen.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  List products = [];
  bool isLoading = true;

  Future<void> fetchProductsAPI() async {
    // final response = await http.get(Uri.parse('http://localhost:3000/api/products'));
    final response = await http.get(Uri.parse('http://10.0.2.2/api/products'));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
        isLoading = false;
      });
    }
  }

  Future<void> fetchProductsDB() async {
    final ref = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://flutterauth-9ba4b-default-rtdb.asia-southeast1.firebasedatabase.app',
    ).ref('products');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final value = snapshot.value;
      List productList = [];
      if (value is Map) {
        productList = value.values.toList();
      } else if (value is List) {
        productList = value.where((e) => e != null).toList();
      }
      setState(() {
        products = productList;
        isLoading = false;
        print(products);
      });
    } else {
      setState(() {
        products = [];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchProductsAPI();
    fetchProductsDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Computer Products')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    leading: Image.network(product['image']),
                    title: Text(product['name']),
                    subtitle: Text('฿${product['price']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
