import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:ledger/services/message_service/service.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  bool buttonPressed = false;
  bool synced = false;
  List<SmsMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return !buttonPressed
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async => syncMessages(),
                    child: const Text("Sync")),
              ],
            ),
          )
        : !synced
            ? const CircularProgressIndicator()
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
              );
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
