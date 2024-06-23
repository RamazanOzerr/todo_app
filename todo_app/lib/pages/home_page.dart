import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  toDoDatabase db = toDoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if the first time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  final _controller = TextEditingController();

  /*
  List toDoList = [
    ["first tast", false],
    ["second task", false],
  ];
  */

  void checkBoxChanged(int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updataData();
  }

  void onSave() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    onCancel();
    db.updataData();
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
      db.toDoList.removeAt(index);
    });
    db.updataData();
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
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            isCompleted: db.toDoList[index][1],
            onChanged: (p0) => checkBoxChanged(index),
            deleteFunction: (p0) => deleteTask(index),
          );
        },
      ),
    );
  }
}
