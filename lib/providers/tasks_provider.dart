import 'package:flutter/material.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  List<Task> _items = [];

  @override
  Tasks() {
    for (int i = 65; i <= 70; i++) {
      _items.add(Task(name: "Entry ${String.fromCharCode(i)}"));
    }
  }

  List<Task> get items {
    return [..._items];
  }

  void addTask(Task task) {
    _items.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
