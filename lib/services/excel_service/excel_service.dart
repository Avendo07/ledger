import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/hive_box.dart';

class ExcelService {
  static saveToExcel() async {
    PermissionStatus filePermission = await Permission.storage.status;
    Box preferencesBox = await Hive.openBox(HiveBoxStore.preferences);
    String? selectedDirectory = await preferencesBox.get(HiveBoxStore.excelSaveDirectory);
    Excel excel = Excel.createExcel();
    if(filePermission == PermissionStatus.granted){
      if (selectedDirectory != null) {
        List<int>? encodedData = excel.encode();
        File("$selectedDirectory/excel.xlsx")
          ..createSync(recursive: true)
          ..writeAsBytesSync(encodedData??[]);
      }
    }else{
      await Permission.storage.request();
    }
  }

  static chooseExcelLocation() async {
    Box preferencesBox = await Hive.openBox(HiveBoxStore.preferences);
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    preferencesBox.put(HiveBoxStore.excelSaveDirectory, selectedDirectory);
  }
}
