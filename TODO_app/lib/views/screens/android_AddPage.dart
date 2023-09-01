import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/dateTime_Controller.dart';

class androidAddPage extends StatelessWidget {
  const androidAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What is to done?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 20),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter Task Here'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Due Date",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 20),
            ),
            Row(children: [
              IconButton(
                  onPressed: () async {
                    DateTime? DT = await showDatePicker(
                      context: context,
                      initialDate: Provider.of<dateTimecontroller>(context,
                              listen: false)
                          .DT,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 5),
                      ),
                    );
                    if (DT != null) {
                      Provider.of<dateTimecontroller>(context, listen: false)
                          .dateTimeChange(dateTime: DT);
                    }
                  },
                  icon: Icon(Icons.date_range)),
              Consumer<dateTimecontroller>(builder: (context, Provider, child) {
                return Text(
                  "${Provider.DT!.day} / ${Provider.DT!.month} / ${Provider.DT!.year}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              }),
            ]),
            SizedBox(
              height: 20,
            ),
            Text(
              "Time",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 20),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    TimeOfDay? TD = await showTimePicker(
                      context: context,
                      initialTime: Provider.of<dateTimecontroller>(context,
                              listen: false)
                          .TD,
                    );
                    if (TD != null) {
                      Provider.of<dateTimecontroller>(context, listen: false)
                          .TimeChange(time: TD);
                    }
                  },
                  icon: Icon(Icons.watch_later_outlined),
                ),
                Consumer<dateTimecontroller>(
                    builder: (context, Provider, child) {
                  return Text(
                    "${Provider.TD!.hour % 12} : ${Provider.TD!.minute} ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(Icons.done),
      ),
    );
  }
}
