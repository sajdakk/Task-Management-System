import 'package:flutter/material.dart';
import 'package:project/_project.dart';

import 'screens/home_screen.dart';

void main() {
  var observer = TaskObserver('task_management');
  TaskManager().addObserver(observer);

  runApp(const HomeScreen());
}
