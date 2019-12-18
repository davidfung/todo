import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/tasks.dart';
import './widget/task_view.dart';

const APP_TITLE = 'Amazing Todo';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Tasks(),
      child: MaterialApp(
        title: 'Amazing Todo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(body1: TextStyle(fontSize: 20.0)),
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      body: TaskView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
