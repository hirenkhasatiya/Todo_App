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
            offset: Offset(20, 40),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("Task Done"),
              ),
              PopupMenuItem(
                onTap: () {
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("select theme color"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Dark"))
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.list));
                },
                child: Text("setting"),
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
              icon: Icon(Icons.apple_rounded)),
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
                      child: Card(
                        child: ListTile(
                          leading: Consumer<taskController>(
                              builder: (context, Provider, child) {
                            return Checkbox(
                              activeColor: Colors.blue,
                              value: Provider.done,
                              onChanged: (val) {
                                Provider.removeTask(task: task);
                                Provider.taskDone();
                              },
                            );
                          }),
                          title: Text(task.T,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(task.Time),
                          trailing: Text(task.Date),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
