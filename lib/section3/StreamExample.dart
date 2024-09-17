import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final dataStreamProvider = StreamProvider<int>(create: (ref) async* {
  for (int i = 0; i < 10; i++) {
    await Future.delayed(Duration(seconds: 2));
    yield i;
  }
});

class StreamExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsyncValue = ref.watch(dataStreamProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Stream Example")),
      body: Center(
        child: dataAsyncValue.when(
          data: (data) => Text('Data: $data', style: TextStyle(fontSize: 40)),
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}

final autoDisposeStreamProvider = StreamProvider.autoDispose<int>((ref) async* {
  for (int i = 0; i < 10; i++) {
    await Future.delayed(Duration(seconds: 2));
    yield i;
  }
});

