import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoProvider extends ChangeNotifier {
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  ToDoProvider() {
    // Initialize the data
    if (_myBox.get('TODOLIST') == null) {
      createInitialData();
    } else {
      loadData();
    }
  }

  void createInitialData() {
    toDoList = [
      ['Make tutorial', false],
      ['Do exercise', false],
    ];
    updateDatabase();
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
    notifyListeners();
  }

  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
    notifyListeners();
  }

  void addTask(String taskName) {
    toDoList.add([taskName, false]);
    updateDatabase();
  }

  void updateTaskStatus(int index, bool isCompleted) {
    toDoList[index][1] = isCompleted;
    updateDatabase();
  }

  void deleteTask(int index) {
    toDoList.removeAt(index);
    updateDatabase();
  }
}
