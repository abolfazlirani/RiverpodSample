
final autoDisposeProvider = FutureProvider.autoDispose<String>((ref) async {
  // فرض کنید این درخواست به یک API واقعی ارسال می‌شود
  await Future.delayed(Duration(seconds: 2));
  return "Data from API";
});

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(autoDisposeProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Auto Dispose Example')),
      body: Center(
        child: data.when(
          data: (value) => Text(value),
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}
