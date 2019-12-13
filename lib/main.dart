import 'package:flutter/material.dart';

const APP_TITLE = 'Amazing Todo';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazing Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(body1: TextStyle(fontSize: 20.0)),
      ),
      home: HomePage(),
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

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final items = List<String>.generate(26, (i) => 'Entry ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text('${items[index]}'));
      },
    );
  }
}

/*
return ListView(
padding: const EdgeInsets.all(8),
children: <Widget>[
TaskItem(name: 'Entry A'),
TaskItem(name: 'Entry B'),
TaskItem(name: 'Entry C'),
TaskItem(name: 'Entry D'),
TaskItem(name: 'Entry E'),
TaskItem(name: 'Entry F'),
TaskItem(name: 'Entry G'),
TaskItem(name: 'Entry H'),
TaskItem(name: 'Entry I'),
TaskItem(name: 'Entry J'),
TaskItem(name: 'Entry K'),
TaskItem(name: 'Entry L'),
TaskItem(name: 'Entry M'),
TaskItem(name: 'Entry N'),
TaskItem(name: 'Entry O'),
TaskItem(name: 'Entry P'),
TaskItem(name: 'Entry Q'),
TaskItem(name: 'Entry R'),
TaskItem(name: 'Entry S'),
TaskItem(name: 'Entry T'),
TaskItem(name: 'Entry U'),
TaskItem(name: 'Entry V'),
TaskItem(name: 'Entry W'),
TaskItem(name: 'Entry X'),
TaskItem(name: 'Entry Y'),
TaskItem(name: 'Entry Z'),
],
);
*/
class TaskTile extends StatelessWidget {
  final String name;

  const TaskTile({
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.name),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String name;

  const TaskItem({
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Text(
        this.name,
      ),
    );
  }
}
