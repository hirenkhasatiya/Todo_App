import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/Modals/todo_modal.dart';

import '../../Helpers/fb_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("done");
            },
            icon: Icon(Icons.list),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FbHelper.fbHelper.getToDo(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              QuerySnapshot? snaps = snapShot.data;
              List<QueryDocumentSnapshot> data = snaps?.docs ?? [];
              List<TaskModal> AllTask = data
                  .map(
                    (e) => TaskModal.FromMap(data: e.data() as Map),
                  )
                  .toList();

              AllTask.sort((a, b) => a.date.compareTo(b.date));

              return ListView.builder(
                  itemCount: AllTask.length,
                  itemBuilder: (context, index) {
                    TaskModal task = AllTask[index];

                    return GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Sure Delete"),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      FbHelper.fbHelper.deletToDo(task: task);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Delete"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      child: task.done
                          ? Container()
                          : Card(
                              child: ListTile(
                                leading: IconButton(
                                  onPressed: () {
                                    task.done = !task.done;
                                    FbHelper.fbHelper.completToDo(task: task);
                                    FbHelper.fbHelper.doneToDo(task: task);
                                  },
                                  icon: Icon(
                                    task.done
                                        ? Icons.check_box_rounded
                                        : Icons.check_box_outline_blank,
                                  ),
                                ),
                                title: Text(task.task),
                                trailing: Text(task.date),
                              ),
                            ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          late String t;
          late TimeOfDay? Time;
          late DateTime? Date;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("ADD TODO"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (val) => t = val,
                    decoration:
                        const InputDecoration(hintText: 'Enter Task Here'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text("Select Date"),
                      IconButton(
                          onPressed: () async {
                            DateTime? DT = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 10),
                              ),
                            );
                            if (DT != Null) {
                              Date = DT;
                            }
                          },
                          icon: const Icon(Icons.date_range)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Select Time"),
                      IconButton(
                        onPressed: () async {
                          TimeOfDay? TD = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (TD != Null) {
                            Time = TD;
                          }
                        },
                        icon: const Icon(Icons.watch_later_outlined),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        TaskModal task = TaskModal(
                          date: "${Date?.year}-${Date?.month}-${Date?.day}",
                          time: "${Time!.hour % 12} : ${Time?.minute}",
                          task: t,
                          done: false,
                        );

                        FbHelper.fbHelper.addToDo(task: task);

                        Navigator.of(context).pop();
                      },
                      child: const Text("Done"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
