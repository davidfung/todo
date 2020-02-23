import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/task_view.dart';
import './pages/addtask_page.dart';
import './pages/edittask_page.dart';
import './providers/tasks_provider.dart';

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
          '/edittask': (context) => EditTaskPage(),
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(title: Text('Settings')),
            ListTile(title: Text('About')),
          ],
        ),
      ),
      body: TaskView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addtask');
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
