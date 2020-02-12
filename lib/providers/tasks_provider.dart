import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';

class Tasks with ChangeNotifier {
  List<Task> _items = [];
  Database db;

  @override
  Tasks() {
    for (int i = 65; i <= 70; i++) {
      _items.add(Task(name: "Entry ${String.fromCharCode(i)}"));
    }
    _dbInit();
  }

  Future<void> _dbInit() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE task(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> _dbInsert(Task task) async {
    await db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  List<Task> get items {
    return UnmodifiableListView<Task>(_items);
  }

  void addTask(Task task) {
    _items.add(task);
    _dbInsert(task);
    notifyListeners();
  }

  void editTask(int index, String name) {
    _items[index].name = name;
    notifyListeners();
  }

  void removeTask(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
