import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_app/database/database.dart';

import '../util/dislog_box.dart';
import '../util/todo_tile.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

  //  连接本地Hive数据库，并定义db
  final _myBox = Hive.box('mybox');
  // 定义db
  ToDoDataBase db = ToDoDataBase();

  // 定义初始化方法
  @override
  void initState() {
    // TODO: implement initState
    // 如果是首次加载app，那么就创建默认的list列表；否则从hive数据库中获取数据
    if (_myBox.get('TODOLIST') == null){
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }


  void onChanged(int index) {
    setState(() {
      db.taskList[index][1] = !db.taskList[index][1];
    });
    db.updateData();
  }

  final _my_controller = TextEditingController();

  void onSave(){
    setState(() {
      db.taskList.add([
        _my_controller.text,
        false
      ]);
      _my_controller.clear();
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  // 新增按钮功能
  void addNew() {
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: _my_controller,
        onSave: onSave,
        onCancel: () => Navigator.of(context).pop(),
      );
    });
    db.updateData();
  }

  // 删除目标任务
  void deleteItem(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.amberAccent[200],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNew,
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.yellow[200],
      body:ListView.builder(
        itemCount: db.taskList.length,
        itemBuilder: (context,index)  {
          return ToDoTile(
            taskName: db.taskList[index][0],
            taskStatus: db.taskList[index][1],
            onChanged: (value) => onChanged(index),
              deleteItem:(context) => deleteItem(index),
          );
        },
      )
    );
  }
}
