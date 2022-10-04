import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:ledger/services/excel_service/excel_service.dart';
import 'package:ledger/services/message_service/service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
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
    final List list = ["Hello", "How are you"];
    MessageService service = MessageService();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: !buttonPressed
            ? Column(
                children: [
                  ElevatedButton(
                      onPressed: () async => syncMessages(),
                      child: Text("Sync")),
                  ElevatedButton(
                      onPressed: () => ExcelService.saveToExcel(),
                      child: Text("Save File"))
                ],
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
