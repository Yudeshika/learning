import 'package:hive/hive.dart';

class ToDoDatabase {
  List ToDoList = [];

  // reference the hive box
  final _todoBox = Hive.box('todoBox');

  // run this method is this is the first time the app is run
  void init() {
    // add the initial data to the hive box
    ToDoList = [
      ["First Flutter App", false],
      ["Do Exercise", false],
      ["Second Flutter App", false]
    ];
  }

  // load data from the database
  void loadData() {
    ToDoList = _todoBox.get('todoList', defaultValue: []);
  }

// add data to the database
  void addData(String taskname, bool isDone) {
    ToDoList.add([taskname, isDone]);
  }

  // update the completion status of a task
  void updateData(int index, bool isDone) {
    // ToDoList[index][1] = isDone;
    _todoBox.put("TODOLIST", ToDoList);
  }

  // delete a task
  void deleteData(int index) {
    ToDoList.removeAt(index);
  }
}
