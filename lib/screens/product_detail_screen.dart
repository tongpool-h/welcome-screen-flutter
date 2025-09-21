import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product['image'], height: 120)),
            const SizedBox(height: 24),
            Text(product['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Price: ฿${product['price']}', style: const TextStyle(fontSize: 18)),
            // Add more product details here if needed
          ],
        ),
      ),
    );
  }
}