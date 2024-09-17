import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final userProvider = Provider<User>((ref) {
  return User(name: "John Doe", age: 30);
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  return fetchProductsFromApi();
});

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final productsAsyncValue = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Hello, ${user.name}')),
      body: productsAsyncValue.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(products[index].name),
          ),
        ),
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
