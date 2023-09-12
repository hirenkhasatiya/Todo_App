import 'package:flutter/material.dart';
import 'package:todo_app/Modals/task_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class taskController extends ChangeNotifier {
  DateTime DT = DateTime.now();

  TimeOfDay timedate = TimeOfDay.now();
  late SharedPreferences preferences;

  taskController({required this.preferences});

  List<Task> _allTask = [];

  List<Task> _DoneTask = [];

  List<String> doneT = [];
  List<String> doneTime = [];
  List<String> doneDate = [];

  List<String> allT = [];
  List<String> allTime = [];
  List<String> allDate = [];

  init() {
    allT = preferences.getStringList("Task") ?? [];
    allTime = preferences.getStringList("Time") ?? [];
    allDate = preferences.getStringList("Date") ?? [];

    _allTask = List.generate(
      allT.length,
      (index) => Task(
        Date: allT[index],
        Time: allTime[index],
        task: allDate[index],
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

  List<Task> get getTaskDone {
    init();
    return _DoneTask;
  }

  addTask({required Task task}) {
    if (!_allTask.any((element) => element.task == task.task)) {
      _allTask.add(task);

      allT.add(task.task);
      allTime.add(task.Time);
      allDate.add(task.Date);

      set();
    }
    notifyListeners();
  }

  doneTask({required Task task}) {
    if (!_DoneTask.any((element) => element.Date == task.Date)) {
      _DoneTask.add(task);

      doneDate.add(task.task);
      doneTime.add(task.Time);
      doneT.add(task.Date);
      set();
    }
    notifyListeners();
  }

  removeTask({required int index}) {
    init();

    allT.removeAt(index);
    allTime.removeAt(index);
    allDate.removeAt(index);

    set();

    notifyListeners();
  }

  editContact({required int index, required Task task}) {
    init();
    allT[index] = task.Date;
    allDate[index] = task.task;
    allTime[index] = task.Time;

    set();
  }

  dateTimeChange({required DateTime dateTime}) {
    DT = dateTime;
    notifyListeners();
  }

  timeChange({required TimeOfDay time}) {
    timedate = time;
    notifyListeners();
  }
}
