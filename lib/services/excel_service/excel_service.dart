import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/hive_box.dart';

class ExcelService {
  static saveToExcel(Excel excel) async {
    PermissionStatus filePermission = await Permission.storage.status;
    Box preferencesBox = await Hive.openBox(HiveBoxStore.preferences);
    String? selectedDirectory = await preferencesBox.get(HiveBoxStore.excelSaveDirectory);
    if(filePermission == PermissionStatus.granted){
      if (selectedDirectory != null) {
        List<int>? encodedData = excel.encode();
        File("$selectedDirectory/excel.xlsx")
          ..createSync(recursive: true)
          ..writeAsBytesSync(encodedData??[]);
      }else{
        print("Unable to save");
      }
    }else{
      await Permission.storage.request();
    }
  }

  static Excel newExcel(){
    Excel excel = Excel.createExcel();
    // saveToExcel(excel);
    return excel;
  }

  static void chooseExcelLocation() async {
    Box preferencesBox = await Hive.openBox(HiveBoxStore.preferences);
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    preferencesBox.put(HiveBoxStore.excelSaveDirectory, selectedDirectory);
  }

  static void addRow(List data, Sheet sheet){
    sheet.appendRow(data);
  }

  static Future<Excel?> readExcelSheet() async {
    PermissionStatus filePermission = await Permission.storage.status;
    if(filePermission == PermissionStatus.granted){
      Box preferencesBox = await Hive.openBox(HiveBoxStore.preferences);
      String? selectedDirectory = await preferencesBox.get(HiveBoxStore.excelSaveDirectory);
      if (selectedDirectory != null) {
        var file = "$selectedDirectory/excel.xlsx";
        var bytes = await File(file).readAsBytes();
        Excel excel = Excel.decodeBytes(bytes);
        return excel;
      }
    }else{
      await Permission.storage.request();
    }
    return null;
  }
}
