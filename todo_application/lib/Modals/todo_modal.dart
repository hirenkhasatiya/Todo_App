class TaskModal {
  String task;
  String time;
  String date;
  bool done = false;

  TaskModal(
      {required this.date,
      required this.time,
      required this.task,
      required this.done});

  factory TaskModal.FromMap({required Map data}) => TaskModal(
        date: data['date'],
        time: data['time'],
        task: data['task'],
        done: data['done'],
      );

  Map<String, dynamic> get toMap => {
        'date': date,
        'time': time,
        'task': task,
        'done': done,
      };
}
