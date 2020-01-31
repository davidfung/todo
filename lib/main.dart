import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './model/task.dart';
import './page/addtask_page.dart';
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
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/addtask': (context) => AddTaskPage(),
        },
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
        onPressed: () {
          _gotoAddTaskPage(context);
          print("hahaha");
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  void _gotoAddTaskPage(BuildContext context) async {
    final dynamic result = await Navigator.pushNamed(context, '/addtask');
//    final String result = await Navigator.push(
//        context, MaterialPageRoute(builder: (context) => AddTaskPage()));
    print(result);
    Provider.of<Tasks>(context).addTask(Task(name: result));
  }
}
