import 'package:flutter_riverpod/flutter_riverpod.dart';

final complexListProvider = StateNotifierProvider<ComplexListNotifier, List<String>>((ref) {
  return ComplexListNotifier();
});

class ComplexListNotifier extends StateNotifier<List<String>> {
  ComplexListNotifier() : super([]);

  void addItem(String item) {
    state = [...state, item];
  }

  void removeItem(String item) {
    state = state.where((i) => i != item).toList();
  }
}
