// Model: کلاس داده‌ها
class CounterModel {
  int count = 0;

  void increment() {
    count++;
  }
}

// View: رابط کاربری
class CounterView extends StatelessWidget {
  final CounterController controller;

  CounterView(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MVC Example')),
      body: Center(
        child: Text('Count: ${controller.model.count}', style: TextStyle(fontSize: 40)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

// Controller: مدیریت ورودی‌ها و هماهنگی بین مدل و ویو
class CounterController {
  CounterModel model = CounterModel();

  void increment() {
    model.increment();
  }
}

// اجرای اپلیکیشن
void main() {
  runApp(MaterialApp(
    home: CounterView(CounterController()),
  ));
}
