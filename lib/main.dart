import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ledger/constants/enum.dart';
import 'package:ledger/constants/hive_box.dart' as constants;
import 'package:ledger/ui/homepage.dart';
import 'package:ledger/view_model/home_controller.dart';

import 'model/transaction.dart';
import 'routing/routes.dart';

void main() {
  Hive.initFlutter().then((value) {
    Hive.registerAdapter(TransactionAdapter());
    Hive.registerAdapter(TransactionTypeAdapter());
    Hive.openBox<Transaction>(constants.transactionBox);
  });
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
