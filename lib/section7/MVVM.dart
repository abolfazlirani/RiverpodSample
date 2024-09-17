// Model: کلاس داده‌ها
class CounterModel {
  int count = 0;

  void increment() {
    count++;
  }
}

// ViewModel: واسطه بین View و Model
class CounterViewModel extends ChangeNotifier {
  final CounterModel _model = CounterModel();

  int get count => _model.count;

  void increment() {
    _model.increment();
    notifyListeners();
  }
}

// View: رابط کاربری
class CounterView extends StatelessWidget {
  final CounterViewModel viewModel;

  CounterView(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MVVM Example')),
      body: Center(
        child: Text('Count: ${viewModel.count}', style: TextStyle(fontSize: 40)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

// اجرای اپلیکیشن
void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
      create: (_) => CounterViewModel(),
      child: Consumer<CounterViewModel>(
        builder: (context, viewModel, child) {
          return CounterView(viewModel);
        },
      ),
    ),
  ));
}
