import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Helpers/fb_helper.dart';
import '../../Modals/todo_modal.dart';

class DoneTask extends StatelessWidget {
  const DoneTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Done"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FbHelper.fbHelper.getdoneToDo(),
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
                          ? Card(
                              child: ListTile(
                                leading: const Icon(Icons.check_box_rounded),
                                title: Text(task.task),
                                trailing: Text(task.date),
                              ),
                            )
                          : const Center(
                              child: Icon(CupertinoIcons.multiply_circle_fill),
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
    );
  }
}
