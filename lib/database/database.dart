import 'package:hive/hive.dart';

// 创建nosql数据库

class ToDoDataBase {
  List taskList = [];

  // 定义自己的盒子
  final _myBox = Hive.box('mybox');

  //  App初始化的时候，创建初始化数据库内容
  void createInitialData(){
    taskList = [
      ['吃饭睡觉',false],
      ['起床吃饭',false],
    ];
  }

  // 加载数据库中的内容
  void loadData() {
    taskList = _myBox.get('TODOLIST');
  }

  // 修改数据库中的内容
  void updateData() {
    _myBox.put('TODOLIST', taskList);
  }
}
