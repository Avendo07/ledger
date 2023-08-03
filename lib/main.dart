import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ledger/ui/homepage.dart';
import 'package:ledger/ui/settings.dart';
import 'package:ledger/view_model/home_controller.dart';

void main() {
  Hive.initFlutter();
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "/home": (buildContext) => const HomePage(),
        "/settings": (buildContext) => Settings(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
