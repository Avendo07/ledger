import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ExcelService {
  static saveToExcel() async {
    PermissionStatus filePermission = await Permission.storage.status;
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
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
}
