import 'package:flutter/material.dart';
import 'package:my_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  // 创建输入框控制器,从父组件传来
  final controller;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent[100],
      content: Container(
        height: 110,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  保存按钮
                MyButton(text: 'Save', onPressed: onSave),
                // 使用box做两个按钮之间的间隔
                SizedBox(width: 8,height: 52,),
                //  取消按钮
                MyButton(text: 'Cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
