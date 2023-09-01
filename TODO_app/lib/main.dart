import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/platform_controller.dart';
import 'package:todo_app/views/screens/android_AddPage.dart';
import 'package:todo_app/views/screens/android_homePage.dart';
import 'package:todo_app/views/screens/iOS_homePage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => platformcontroller(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<platformcontroller>(context).isandroid
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                color: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            routes: {
              '/': (context) => android_HomePage(),
              'add_Page': (context) => androidAddPage(),
            },
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(brightness: Brightness.light),
            home: iOS_homePage(),
          );
  }
}
