import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ledger/services/message_service/sync_messages.dart';

void main() {

  /*setUpAll(() async {
    final envVars = Platform.environment;
    final adbPath = join(
      envVars['ANDROID_SDK_ROOT']??envVars['ANDROID_HOME']??"",
      'platform-tools',
      Platform.isWindows ? 'adb.exe' : 'adb',
    );
    await Process.run(adbPath, [
      'shell',
      'pm',
      'grant',
      'com.example.ledger', // replace with your app id
      'android.permission.READ_SMS'
    ]);
  });*/

  /*group("Test sms inbox package", () {
    test("Test inbox messages", () async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      MessageService messageService = MessageService();
      List<SmsMessage> messages = await messageService.getAllMessages();
      print(messages);
    });
  });*/
}
