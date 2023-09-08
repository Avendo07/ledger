import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

Future<DateTime?> showDateTimePickerWidget(BuildContext context) {
  return showOmniDateTimePicker(
    context: context,
    initialDate: DateTime.now(),
  );
}
