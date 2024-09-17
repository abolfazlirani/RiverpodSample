import 'package:flutter/material.dart';

final largeDataProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  await Future.delayed(Duration(seconds: 2));
  return List.generate(10000, (index) => 'Item $index');
});

class LargeDataWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(largeDataProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Large Data Example')),
      body: data.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => ListTile(title: Text(items[index])),
        ),
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}

class ScopedProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScopedScreen(),
    );
  }
}

class ScopedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Scoped Provider Example')),
      body: Center(
        child: Text('Count: $count', style: TextStyle(fontSize: 40)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}
