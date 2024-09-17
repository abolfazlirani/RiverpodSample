import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final productDetailsProvider = FutureProvider.family<ProductDetails, int>((ref, productId) async {
  return fetchProductDetails(productId);
});

class ProductDetailsPage extends ConsumerWidget {
  final int productId;
  ProductDetailsPage({required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailsAsyncValue = ref.watch(productDetailsProvider(productId));

    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: productDetailsAsyncValue.when(
        data: (details) => Text('Product Name: ${details.name}'),
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
