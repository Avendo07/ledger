import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/services/excel_service/excel_service.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () => ExcelService.chooseExcelLocation(),
              child: Text("Choose Excel Location")),
        ));
  }
}
