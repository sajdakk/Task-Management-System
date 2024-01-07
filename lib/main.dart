import 'package:flutter/material.dart';
import 'package:project/_project.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String databaseFile = 'task_management';
  var observer = DatabaseTaskObserver(databaseFile);
  TaskManager().addObserver(observer);
  await TaskManager().init(databaseFile);

  runApp(const HomeScreen());
}
