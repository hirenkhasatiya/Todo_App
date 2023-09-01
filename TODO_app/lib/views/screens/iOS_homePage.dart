import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/platform_controller.dart';

class iOS_homePage extends StatelessWidget {
  const iOS_homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.activeBlue,
        middle: Text("TODO App",
            style: TextStyle(
              color: CupertinoColors.white,
            )),
        trailing: Consumer<platformcontroller>(
          builder: (context, Provider, child) {
            return GestureDetector(
              onTap: () {
                Provider.changePlatform();
              },
              child: Icon(
                Icons.android_rounded,
                color: CupertinoColors.white,
              ),
            );
          },
        ),
      ),
      child: Center(
        child: Text(""),
      ),
    );
  }
}
