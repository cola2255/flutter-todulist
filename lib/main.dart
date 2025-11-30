import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_app/pages/todo_page.dart';

void main() async {
  // 项目入口打开Hive数据库
  await Hive.initFlutter();

  // 初始化数据库
  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoPage(),
    );
  }
}

