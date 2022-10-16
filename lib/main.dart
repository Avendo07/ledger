import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ledger/constants/enum.dart';
import 'package:ledger/repositories/transaction_repository.dart';
import 'package:ledger/services/excel_service/excel_service.dart';
import 'package:ledger/services/message_service/service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'model/transaction.dart';

void main() {
  Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Ledger'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool buttonPressed = false;
  bool synced = false;
  List<SmsMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(widget.title),
      ),
      /*body: ListView.builder(
            itemBuilder: (buildContext, index){

            },
            itemCount: ,
          )*/
      body: !buttonPressed
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async => syncMessages(),
                      child: Text("Sync")),
                  ElevatedButton(
                      onPressed: () => ExcelService.newExcel(),
                      child: Text("Save File")),
                  ElevatedButton(
                      onPressed: () => ExcelService.chooseExcelLocation(),
                      child: Text("Choose Excel Location")),
                  ElevatedButton(
                      onPressed: () async {
                        Excel? x = await ExcelService.readExcelSheet();
                        if (x != null) {
                          Sheet? sheet =
                              x.sheets[x.getDefaultSheet() ?? "Sheet1"];
                          if (sheet != null) {
                            ExcelService.addRow(
                                ["Hello", "How", "are", "You"], sheet);
                            ExcelService.saveToExcel(x);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Updated the sheet")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Could not open the sheet")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Could not open the excel")));
                        }
                      },
                      child: Text("Add Data"))
                ],
              ),
            )
          : !synced
              ? CircularProgressIndicator()
              : ListView(
                  children: messages
                      .map((message) => ListTile(
                            leading: Text(message.id.toString()),
                            title: Text(message.sender ?? ""),
                            trailing: Text(
                              message.date.toString(),
                            ),
                            subtitle: Text(message.body ?? ""),
                          ))
                      .toList(),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              bool isCredit = false;
              int amount = 0;
              return StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(
                          value: isCredit,
                          onChanged: (value) {
                            setState(() {
                              isCredit = value;
                            });
                          }),
                      TextFormField(
                        onChanged: (String amountString) =>
                            amount = int.parse(amountString),
                        initialValue: "0",
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel")),
                    ElevatedButton(
                      onPressed: () async {
                        print("$amount, $isCredit");

                        Excel? _excel = await ExcelService.readExcelSheet();
                        TransactionRepository repo =
                            TransactionRepository(_excel!);
                        repo.insert(Transaction(
                            "1", isCredit?TransactionType.credit:TransactionType.debit, amount, DateTime.now()));
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
              );
            }),
        child: Icon(Icons.add),
      ),
    ));
  }

  void syncMessages() async {
    PermissionStatus smsPermission = await Permission.sms.status;
    if (smsPermission.isGranted) {
      setState(() {
        buttonPressed = true;
        synced = false;
      });
      MessageService messageService = MessageService();
      messages = await messageService.getAllMessages();
      setState(() {
        buttonPressed = true;
        synced = true;
      });
      print(messages);
    } else {
      await Permission.sms.request();
      setState(() {
        buttonPressed = false;
        synced = false;
      });
    }
  }
}
