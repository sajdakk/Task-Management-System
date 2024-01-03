import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:project/_project.dart';

import 'home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ThColors.backgroundBG1),
        useMaterial3: true,
      ),
      home: const HomePage(),
      builder: (BuildContext context, Widget? child) {
        return BotToastInit()(context, child);
      },
    );
  }
}
