import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageService {
  late SmsQuery smsQuery;
  late PermissionStatus permission;

  MessageService(){
    smsQuery = SmsQuery();
  }

  getMessagesBySender(String sender) async {
    List<SmsMessage> messages =
    await smsQuery.querySms(sort: true, address: sender);
    return messages;
  }

  Future<List<SmsMessage>> getAllMessages() async {
    List<SmsMessage> messages = await smsQuery.getAllSms;
    return messages;
  }
}
