import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/edittask_page.dart';
import '../providers/tasks_provider.dart';
import '../widgets/email_button.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  ScrollController _scrollcontroller;

  @override
  void initState() {
    _scrollcontroller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context);
    return ListView.builder(
      controller: _scrollcontroller,
      itemCount: tasks.items.length,
      itemBuilder: (context, index) {
        final taskName = tasks.items[index].name;
        //_scrollcontroller.jumpTo(0);
        _scrollcontroller.animateTo(0,
            duration: Duration(milliseconds: 750), curve: Curves.ease);
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            tasks.removeTask(index);
          },
          background: Container(
              alignment: AlignmentDirectional.centerStart,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(Icons.cancel, color: Colors.white),
              )),
          child: TaskTile(taskName: taskName, index: index),
          secondaryBackground: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Icon(Icons.cancel, color: Colors.white),
              )),
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key key,
    @required this.taskName,
    @required this.index,
  }) : super(key: key);

  final String taskName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey))),
      child: ListTile(
        title: Text('$taskName'),
        trailing: EmailButton(
          msg: taskName,
        ),
        onTap: () {
          Navigator.pushNamed(context, EditTaskPage.routeName,
              arguments: index);
        },
      ),
    );
  }
}
