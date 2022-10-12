import 'package:excel/excel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger/constants/enum.dart';
import 'package:ledger/model/transaction.dart';
import 'package:ledger/repositories/transaction_repository.dart';
import 'package:ledger/services/excel_service/excel_service.dart';

void main() {
  group("Transaction Repository should", () {
    test("", () {
      Excel excel = ExcelService.newExcel();
      TransactionRepository repository = TransactionRepository(excel);
      repository.delete(0);
    });

    test("delete an entry", () {
      Excel excel = ExcelService.newExcel();
      excel.appendRow("Sheet1", ["Hello", 123, DateTime.now(), "Loki"]);
      excel.appendRow("Sheet1", [
        "Buddy",
        456,
        DateTime.now().subtract(const Duration(hours: 1)),
        "Odin"
      ]);
      print(excel.sheets["Sheet1"]?.rows);
      TransactionRepository repository = TransactionRepository(excel);
      repository.delete(1);
      print(excel.sheets["Sheet1"]?.rows);
    });

    test("Insert transaction", () {
      Excel excel = ExcelService.newExcel();
      TransactionRepository repository = TransactionRepository(excel);
      repository.insert(Transaction("1", TransactionType.debit, 123, DateTime.now()));
      print(excel.sheets["Sheet1"]?.rows);
    });

    test("Get one", (){
      Excel excel = ExcelService.newExcel();
      TransactionRepository repository = TransactionRepository(excel);
      repository.insert(Transaction("1", TransactionType.debit, 123, DateTime.now()));
      repository.insert(Transaction("2", TransactionType.credit, 345, DateTime.now().subtract(const Duration(hours: 1)),));
      Transaction? transaction = repository.getOne(0);
      print(transaction);
    });
  });
}
