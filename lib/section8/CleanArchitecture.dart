// مدل وظیفه
class Task {
  final String id;
  final String title;
  bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});
}

// منطق کسب‌وکار
abstract class TaskRepository {
  List<Task> getAllTasks();
  void addTask(Task task);
  void completeTask(String id);
}
class TaskRepositoryImpl implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  List<Task> getAllTasks() => _tasks;

  @override
  void addTask(Task task) {
    _tasks.add(task);
  }

  @override
  void completeTask(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = true;
  }
}
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl();
});

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskListNotifier(repository);
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;

  TaskListNotifier(this._repository) : super(_repository.getAllTasks());

  void addTask(Task task) {
    _repository.addTask(task);
    state = _repository.getAllTasks();
  }

  void completeTask(String id) {
    _repository.completeTask(id);
    state = _repository.getAllTasks();
  }
}
class TaskApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Clean Architecture Example')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                ref.read(taskListProvider.notifier).completeTask(task.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(taskListProvider.notifier).addTask(
            Task(id: DateTime.now().toString(), title: 'New Task'),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
