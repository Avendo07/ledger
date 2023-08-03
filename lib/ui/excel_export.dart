import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:ledger/services/excel_service/excel_service.dart';

class ExcelExport extends StatelessWidget {
  const ExcelExport({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => ExcelService.newExcel(),
              child: const Text("Save File")),
          ElevatedButton(
              onPressed: () => ExcelService.chooseExcelLocation(),
              child: const Text("Choose Excel Location")),
          ElevatedButton(
              onPressed: () async {
                Excel? x = await ExcelService.readExcelSheet();
                if (x != null) {
                  Sheet? sheet = x.sheets[x.getDefaultSheet() ?? "Sheet1"];
                  if (sheet != null) {
                    ExcelService.addRow(["Hello", "How", "are", "You"], sheet);
                    ExcelService.saveToExcel(x);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Updated the sheet")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Could not open the sheet")));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Could not open the excel")));
                }
              },
              child: const Text("Add Data"))
        ],
      ),
    );
  }
}
