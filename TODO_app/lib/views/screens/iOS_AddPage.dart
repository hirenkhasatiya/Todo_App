import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Modals/task_modal.dart';

import '../../controller/Task_Controller.dart';

class iOSAddPage extends StatelessWidget {
  const iOSAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    String Tsk;

    Tsk = "";
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "New Task",
          style: TextStyle(color: CupertinoColors.white),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(CupertinoIcons.back, color: CupertinoColors.white)),
        backgroundColor: CupertinoColors.systemBlue,
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoTextFormFieldRow(
              onChanged: (val) => Tsk = val,
              prefix: SizedBox(width: 40, child: Icon(Icons.task)),
              placeholder: 'Enter Task',
              decoration: BoxDecoration(color: CupertinoColors.systemGrey5),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: const Text("Select Time"),
                        message: SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (time) {
                              Provider.of<taskController>(context,
                                      listen: false)
                                  .timeChange(
                                      time: TimeOfDay.fromDateTime(time));
                            },
                          ),
                        ),
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                          isDestructiveAction: true,
                        ),
                      ),
                    );
                  },
                  child: Text("Time"),
                ),
                Consumer<taskController>(builder: (context, Provider, child) {
                  return Text(
                    "${Provider.timedate.hour % 12} : ${Provider.timedate.minute} ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: const Text("Select Date"),
                        message: SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: Provider.of<taskController>(
                                    context,
                                    listen: false)
                                .DT,
                            onDateTimeChanged: (date) {
                              Provider.of<taskController>(context,
                                      listen: false)
                                  .dateTimeChange(dateTime: date);
                            },
                          ),
                        ),
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                          isDestructiveAction: true,
                        ),
                      ),
                    );
                  },
                  child: Text("Date"),
                ),
                Consumer<taskController>(builder: (context, Provider, child) {
                  return Text(
                    "${Provider.DT.day} / ${Provider.DT.month} / ${Provider.DT.year}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                }),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: const Text("Done"),
                  onPressed: () {
                    Task T = Task(
                      Date: Tsk,
                      task: Provider.of<taskController>(context, listen: false)
                          .DT
                          .toString(),
                      Time: Provider.of<taskController>(context, listen: false)
                          .timedate
                          .toString(),
                    );

                    Provider.of<taskController>(context, listen: false)
                        .addTask(task: T);
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
