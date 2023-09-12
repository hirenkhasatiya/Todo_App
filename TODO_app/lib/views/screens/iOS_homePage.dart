import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/platform_controller.dart';

import '../../Modals/task_modal.dart';
import '../../controller/Task_Controller.dart';

class iOS_homePage extends StatelessWidget {
  const iOS_homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('add_Page');
            },
            child: Icon(CupertinoIcons.add, color: Colors.white)),
        backgroundColor: CupertinoColors.activeBlue,
        middle: const Text("TODO App",
            style: TextStyle(
              color: CupertinoColors.white,
            )),
        trailing: Consumer<platformcontroller>(
          builder: (context, Provider, child) {
            return GestureDetector(
              onTap: () {
                Provider.changePlatform();
              },
              child: const Icon(
                Icons.android_rounded,
                color: CupertinoColors.white,
              ),
            );
          },
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 80),
        child: Consumer<taskController>(
          builder: (context, Provider, child) => Provider.getTask.isNotEmpty
              ? ListView.builder(
                  itemCount: Provider.getTask.length,
                  itemBuilder: (context, index) {
                    Task task = Provider.getTask[index];
                    return GestureDetector(
                      onLongPress: () {},
                      child: Card(
                        child: ListTile(
                          title: Text(
                            task.task,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              "${Provider.timedate.hour % 12}:${Provider.timedate.minute}"),
                          trailing: GestureDetector(
                              onTap: () {
                                Provider.removeTask(index: index);
                              },
                              child: Icon(CupertinoIcons.delete_solid)),
                          leading: IconButton(
                              onPressed: () {
                                Provider.doneTask(task: task);
                                Provider.removeTask(index: index);
                              },
                              icon: const Icon(Icons.done)),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('add_Page');
                        },
                        child: const Icon(Icons.add,
                            color: CupertinoColors.systemBlue, size: 100),
                      ),
                      const Text(
                        "Please Add Task",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.systemBlue),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
