import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/dateTime_Controller.dart';

class androidAddPage extends StatelessWidget {
  const androidAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    String Task, Date, Time;

    Task = Date = Time = "";

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
              onChanged: (val) => Task = val,
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
            TextField(
              onChanged: (val) => Date = val,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? DT = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            Duration(days: 5),
                          ),
                        );
                        if (DT != null) {
                          Provider.of<dateTimecontroller>(context)
                              .dateTimeChange(dateTime: DT);
                        }
                      },
                      icon: Icon(Icons.date_range)),
                  hintText: Date.isEmpty ? "Date not set" : Date),
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
