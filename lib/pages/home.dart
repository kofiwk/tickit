import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickit/provider/provider.dart';
import 'package:tickit/utilities/dialog_box.dart';
import 'package:tickit/utilities/todo_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoProvider = Provider.of<ToDoProvider>(context);

    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text(
          'TickIt',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController controller = TextEditingController();
              return DialogBox(
                controller: controller,
                onSave: () {
                  if (controller.text.isNotEmpty) {
                    toDoProvider.addTask(controller.text);
                    Navigator.of(context).pop();
                  }
                },
                onCancel: () => Navigator.of(context).pop(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoProvider.toDoList.length,
        itemBuilder: (context, index) {
          final task = toDoProvider.toDoList[index];
          return ToDoTile(
            taskName: task[0],
            taskCompleted: task[1],
            onChanged: (value) {
              toDoProvider.updateTaskStatus(index, value!);
            },
            deleteFunction: (context) {
              toDoProvider.deleteTask(index);
            },
          );
        },
      ),
    );
  }
}
