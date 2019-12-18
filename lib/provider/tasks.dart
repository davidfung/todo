import 'package:flutter/material.dart';

import '../model/task.dart';

class Tasks with ChangeNotifier {
  List<Task> _items = [];

  @override
  Tasks() {
    for (int i = 65; i <= 90; i++) {
      _items.add(Task(name: "Entry ${String.fromCharCode(i)}"));
    }
  }

  List<Task> get items {
    return [..._items];
  }

  void addTask() {
    //_items.add(value);
    notifyListeners();
  }
}
