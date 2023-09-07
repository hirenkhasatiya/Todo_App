import 'package:flutter/material.dart';
import 'package:todo_app/Modals/task_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class taskController extends ChangeNotifier {
  DateTime DT = DateTime.now();

  TimeOfDay TD = TimeOfDay.now();

  bool done = false;

  late SharedPreferences preferences;

  taskController({required this.preferences});

  List<Task> _allTask = [];

  List<String> allT = [];
  List<String> allTime = [];
  List<String> allDate = [];

  taskDone({required index}) {
    done = !done;
    notifyListeners();
  }

  init() {
    allT = preferences.getStringList("Task") ?? [];
    allTime = preferences.getStringList("Time") ?? [];
    allDate = preferences.getStringList("Date") ?? [];

    _allTask = List.generate(
      allT.length,
      (index) => Task(
        T: allT[index],
        Time: allTime[index],
        Date: allDate[index],
      ),
    );
  }

  set() {
    preferences
      ..setStringList("Task", allT)
      ..setStringList("Time", allTime)
      ..setStringList("Date", allDate);

    notifyListeners();
  }

  List<Task> get getTask {
    init();
    return _allTask;
  }

  addTask({required Task task}) {
    if (!_allTask.any((element) => element.Date == task.Date)) {
      _allTask.add(task);

      allT.add(task.Date);
      allTime.add(task.Time);
      allDate.add(task.T);

      set();
    }
    notifyListeners();
  }

  removeTask({required Task task}) {
    init();

    int index = _allTask.indexOf(task);

    allT.removeAt(index);
    allTime.removeAt(index);
    allDate.removeAt(index);

    set();

    notifyListeners();
  }

  dateTimeChange({required DateTime dateTime}) {
    DT = dateTime;
    notifyListeners();
  }

  timeChange({required TimeOfDay time}) {
    TD = time;
    notifyListeners();
  }
}
