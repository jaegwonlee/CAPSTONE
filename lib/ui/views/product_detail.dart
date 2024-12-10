import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product['image']),
            const SizedBox(height: 16),
            Text(product['name'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Price: \$${product['price']}',
                style: const TextStyle(fontSize: 18)),
            // 추가적인 상품 정보
          ],
        ),
      ),
    );
  }
}
