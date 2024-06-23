import 'package:flutter/material.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List toDoList = [
    ["first tast", false],
    ["second task", false],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void onSave() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    onCancel();
  }

  void onCancel() {
    // works like finish() method in android
    Navigator.of(context).pop();
  }

  void createNewTask() {
    print("button clicked");
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: onSave,
          onCancel: onCancel,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 235, 159),
      appBar: AppBar(
        title: const Text("TO DO"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            isCompleted: toDoList[index][1],
            onChanged: (p0) => checkBoxChanged(index),
            deleteFunction: (p0) => deleteTask(index),
          );
        },
      ),
    );
  }
}
