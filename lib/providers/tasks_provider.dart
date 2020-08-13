import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';

// the key represents the version of the db
// TODO only support one sql statement in each version?
Map<int, String> migrationScripts = {
  1: '''
CREATE TABLE task (
  id INTEGER PRIMARY KEY, 
  name TEXT)
  ''',
  2: '''
ALTER TABLE task ADD timestamp DATETIME;
  ''',
  3: '''
CREATE TRIGGER insert_timestamp
AFTER INSERT ON task
BEGIN
   UPDATE task SET timestamp =STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;
  ''',
  4: '''
CREATE TRIGGER update_timestamp
AFTER UPDATE On task
BEGIN
   UPDATE task SET timestamp = STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW') WHERE id = NEW.id;
END;
''',
};

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
    //TODO: make it an option to add to top or bottom of list
    //// _items.add(task);
    _items.insert(0, task);
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
    int nbrMigrationScripts = migrationScripts.length;
    db = await openDatabase(
      join(await getDatabasesPath(), "todo.db"),
      version: nbrMigrationScripts,
      // if the database does not exist, onCreate executes all the sql requests of the "migrationScripts" map
      onCreate: (Database db, int version) async {
        print('**************************** onCreate: $version');
        for (int i = 1; i <= nbrMigrationScripts; i++) {
          print('**************************** migrating version: $i');
          await db.execute(migrationScripts[i]);
        }
      },

      /// if the database exists but the version of the database is different
      /// from the version defined in parameter, onUpgrade will execute all sql requests greater than the old version
      onUpgrade: (db, oldVersion, newVersion) async {
        print(
            '**************************** onUpgrade: $oldVersion -> $newVersion');
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          print('**************************** migrating version: $i');
          await db.execute(migrationScripts[i]);
        }
      },
    );
  }

  Future<void> _dbLoad() async {
    final List<Map<String, dynamic>> maps = await db.query('task');
    // Convert the List<Map<String, dynamic> into a List<Task>.
    _items = List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        name: maps[i]['name'],
        timestamp: maps[i]['timestamp'] ?? "",
      );
    });
    // Sort the item list by last modified time descending
    _items.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
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
