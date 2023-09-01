import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/platform_controller.dart';

class android_HomePage extends StatelessWidget {
  const android_HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO App"),
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
        padding: EdgeInsets.all(20),
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
