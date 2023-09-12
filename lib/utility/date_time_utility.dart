import 'package:intl/intl.dart';

String formatTimeStampString(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd kk:mm:ss");
  String timeStampString = dateFormat.format(dateTime);
  return timeStampString;
}

DateTime timeStampFromString(String timeStampString) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd kk:mm:ss");
  DateTime formattedTimeStamp = dateFormat.parse(timeStampString);
  return formattedTimeStamp;
}
