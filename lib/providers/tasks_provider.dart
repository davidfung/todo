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
    loadTasks();
  }

  List<Task> get items {
    return UnmodifiableListView<Task>(_items);
  }

  void loadTasks() async {
    await _dbOpen();
    await _dbLoad();
    notifyListeners();
  }

  void addTask(Task task) {
    _items.add(task);
    _dbInsert(task);
    notifyListeners();
  }

  void editTask(int index, String name) {
    _items[index].name = name;
    _dbUpdate(_items[index]);
    notifyListeners();
  }

  void removeTask(int index) {
    _dbDelete(_items[index].id);
    _items.removeAt(index);
    notifyListeners();
  }

  // --------------------------
  // Internal Database Routines
  // --------------------------

  Future<void> _dbOpen() async {
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

  Future<void> _dbLoad() async {
    final List<Map<String, dynamic>> maps = await db.query('task');
    // Convert the List<Map<String, dynamic> into a List<Task>.
    _items = List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<void> _dbInsert(Task task) async {
    await db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _dbUpdate(Task task) async {
    await db.update(
      'task',
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  Future<void> _dbDelete(int id) async {
    await db.delete(
      'task',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
