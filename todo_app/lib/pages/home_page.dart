import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';
import 'package:todo_app/util/my_button.dart';
import 'package:todo_app/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference to the hive box
  final _todoBox = Hive.box('todoBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // run this method is this is the first time the app is run
    if (_todoBox.isEmpty) {
      db.init();
    } else {
      // load data from the database
      db.loadData();
    }

    // load data from the database
    db.loadData();

    // TODO: implement initState
    super.initState();
  }

  final _controller = TextEditingController();

  // list of tasks
  // List<Map<String, dynamic>> toDoList = [
  //   {'taskname': 'Task 1', 'isDone': false},
  //   {'taskname': 'Task 2', 'isDone': false},
  //   {'taskname': 'Task 3', 'isDone': false},
  // ];

  // checkbox onChanged function
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      // Update the completion status of the todo item at the specified index
      db.ToDoList[index]['isDone'] = value;
    });
  }

  // save a new task function
  void saveNewTask() {
    final taskname = _controller.text;
    if (taskname.isNotEmpty) {
      setState(() {
        db.ToDoList.add({'taskname': taskname, 'isDone': false});
        _controller.clear();
      });
      Navigator.pop(context);
    }
  }

  // create new task function
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        title: Text('To Do App'),
      ),

      // add new task button
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          final task = db.ToDoList[index];
          return ToDoTile(
            taskname: task['taskname'] ?? 'Task Name Missing',
            isDone: task['isDone'] ?? false,
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (BuildContext context) {
              setState(() {
                db.ToDoList.removeAt(index);
              });
              db.updateData(index, false);
            },
          );
        },
      ),
    );
  }
}
