import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskname;
  final bool isDone;
  final Function(bool?)? onChanged; // Make onChanged nullable
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    Key? key,
    required this.taskname,
    required this.isDone,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        // Wrap Container with ClipRRect
        borderRadius: BorderRadius.circular(10),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(10),
              )

              // IconSlideAction(
              //   caption: 'Delete',
              //   color: Colors.red,
              //   icon: Icons.delete,
              //   onTap: () {},
              // ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.yellow.shade300,
              border: Border.all(
                color: Colors.yellow.shade700,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: isDone,
                  onChanged: onChanged,
                  activeColor: Colors.green.shade400,
                ),
                Text(taskname,
                    style: TextStyle(
                      fontSize: 14,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration
                              .none, // Add line-through decoration if task is done
                    )), // Display taskname
              ],
            ),
          ),
        ),
      ),
    );
  }
}
