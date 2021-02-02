import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './pages/about_page.dart';
import './pages/addtask_page.dart';
import './pages/edittask_page.dart';
import './pages/settings_page.dart';
import './providers/tasks_provider.dart';
import './widgets/main_drawer.dart';
import './widgets/task_view.dart';
import 'constants.dart';

const APP_TITLE = 'Amazing Todo';
const DEFAULT_EMAIL_PREFIX = '[TODO] ';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initSharedPreferences();
  runApp(MyApp());
}

Future<void> _initSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(settingEmail1)) {
    await prefs.setString(settingEmail1, '');
  }
  if (!prefs.containsKey(settingEmail2)) {
    await prefs.setString(settingEmail2, '');
  }
  if (!prefs.containsKey(settingEmail3)) {
    await prefs.setString(settingEmail3, '');
  }
  if (!prefs.containsKey(settingTo1)) {
    await prefs.setBool(settingTo1, true);
  }
  if (!prefs.containsKey(settingTo2)) {
    await prefs.setBool(settingTo2, true);
  }
  if (!prefs.containsKey(settingTo3)) {
    await prefs.setBool(settingTo3, true);
  }
  if (!prefs.containsKey(settingCc1)) {
    await prefs.setBool(settingCc1, false);
  }
  if (!prefs.containsKey(settingCc2)) {
    await prefs.setBool(settingCc2, false);
  }
  if (!prefs.containsKey(settingCc3)) {
    await prefs.setBool(settingCc3, false);
  }
  if (!prefs.containsKey(settingEmailPrefix)) {
    await prefs.setString(settingEmailPrefix, DEFAULT_EMAIL_PREFIX);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Tasks(),
      child: MaterialApp(
        title: 'Amazing Todo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(bodyText2: TextStyle(fontSize: 20.0)),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          AddTaskPage.routeName: (context) => AddTaskPage(),
          EditTaskPage.routeName: (context) => EditTaskPage(),
          AboutPage.routeName: (context) => AboutPage(),
          SettingsPage.routeName: (context) => SettingsPage(),
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
      drawer: MainDrawer(),
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
