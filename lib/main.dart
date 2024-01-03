import 'package:flutter/material.dart';
import 'package:project/_project.dart';

import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  String databaseFile = 'task_management';
  var observer = TaskObserver(databaseFile);
  TaskManager().addObserver(observer);
  TaskManager().init(databaseFile);

  runApp(const HomeScreen());
}
