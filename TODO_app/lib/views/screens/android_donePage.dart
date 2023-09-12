import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Modals/task_modal.dart';
import '../../controller/Task_Controller.dart';

class androidDonePage extends StatelessWidget {
  const androidDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Done Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<taskController>(
          builder: (context, Provider, child) => Provider.getTaskDone.isNotEmpty
              ? ListView.builder(
                  itemCount: Provider.getTaskDone.length,
                  itemBuilder: (context, index) {
                    Task task = Provider.getTaskDone[index];
                    return GestureDetector(
                      child: Card(
                        child: ListTile(
                          title: Text(
                            task.task,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          trailing: Text("Task Done",
                              style: TextStyle(color: Colors.green)),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Done Task",
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
    );
  }
}
