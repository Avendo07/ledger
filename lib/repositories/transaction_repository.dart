import 'package:excel/excel.dart';
import 'package:ledger/model/transaction.dart';
import 'package:ledger/repositories/interface/transaction_repository_interface.dart';

class TransactionRepository extends ITransactionRepository {
  final Excel _excel;

  TransactionRepository(this._excel);

  static const defaultSheetName = "Sheet1";

  @override
  List<Transaction> getAll() {
    var items = _excel.sheets[defaultSheetName]?.rows;
    return items?.map((item) => Transaction.fromList(item)).toList() ?? [];
  }

  @override
  Transaction? getOne(int id) {
    var item = _excel.sheets[defaultSheetName]?.row(id);
    return item != null ? Transaction.fromList(item.map((Data? data) => data?.value).toList()) : null;
  }

  @override
  void insert(Transaction transaction) {
    _excel.appendRow(defaultSheetName, transaction.toList());
  }

  @override
  void update(Transaction transaction) {

  }

  @override
  void delete(int id) async {
    _excel.removeRow(defaultSheetName, id);
  }
}
