import 'package:hive_flutter/hive_flutter.dart';

class toDoDatabase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // if it is the first time ever opening the app
  void createInitialData() {
    toDoList.add(["follow me on github: github.com/ramazanozerr", false]);
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updataData() {
    _myBox.put("TODOLIST", toDoList);
    print("saved successfully");
  }
}
