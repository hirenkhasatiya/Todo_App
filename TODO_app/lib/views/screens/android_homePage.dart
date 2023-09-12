import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Modals/task_modal.dart';
import 'package:todo_app/controller/Task_Controller.dart';
import 'package:todo_app/controller/platform_controller.dart';

class android_HomePage extends StatelessWidget {
  const android_HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO App"),
        leading: Consumer<taskController>(builder: (context, Provider, child) {
          return PopupMenuButton(
            offset: const Offset(20, 40),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  Navigator.of(context).pushNamed('Done_Page');
                },
                child: Text("Task Done"),
              ),
              PopupMenuItem(
                onTap: () {},
                child: const Text("setting"),
              ),
            ],
          );
        }),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<platformcontroller>(context, listen: false)
                    .changePlatform();
              },
              icon: const Icon(Icons.apple_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<taskController>(
          builder: (context, Provider, child) => Provider.getTask.isNotEmpty
              ? ListView.builder(
                  itemCount: Provider.getTask.length,
                  itemBuilder: (context, index) {
                    Task task = Provider.getTask[index];
                    return GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Delete Task"),
                            actions: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Provider.removeTask(index: index);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Delete"),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(task.task,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "${Provider.timedate.hour % 12}:${Provider.timedate.minute}"),
                          trailing: IconButton(
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
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.blue, size: 100),
                      Text(
                        "Please Add Task",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('add_Page');
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
