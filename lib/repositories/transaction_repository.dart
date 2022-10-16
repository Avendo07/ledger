import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:ledger/model/transaction.dart';
import 'package:ledger/repositories/interface/transaction_repository_interface.dart';
import 'package:ledger/services/excel_service/excel_service.dart';

class TransactionRepository extends ITransactionRepository {
  final Excel _excel;

  TransactionRepository(this._excel);

  static String _getSheetName(){
    return DateFormat('MMMM yyyy').format(DateTime.now());
  }

  @override
  List<Transaction> getAll() {
    var items = _excel.sheets[_getSheetName()]?.rows;
    return items?.map((item) => Transaction.fromList(item)).toList() ?? [];
  }

  @override
  Transaction? getOne(int id) {
    var item = _excel.sheets[_getSheetName()]?.row(id);
    return item != null ? Transaction .fromList(item.map((Data? data) => data?.value).toList()) : null;
  }

  @override
  void insert(Transaction transaction) {
    String sheetName = _getSheetName();
    // Sheet sheet;
    // _excel.link(sheetName, sheet);
    _excel.appendRow(sheetName, transaction.toList());
    ExcelService.saveToExcel(_excel);
  }

  @override
  void update(Transaction transaction) {

  }

  @override
  void delete(int id) async {
    _excel.removeRow(_getSheetName(), id);
  }
}
