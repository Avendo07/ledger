import 'package:excel/excel.dart';
import 'package:ledger/model/transaction.dart';

class TransactionRepository {
   final Excel _excel;
  TransactionRepository(this._excel);

  @override
  Future<List<Transaction>> getAll() async {
    var items = await _excel.sheets[_excel.getDefaultSheet()]?.rows;
    return items?.map((item) => Transaction.fromMap(item.ma)).toList()??[];
  }

  @override
  Future<Transaction?> getOne(int id) async {
    var item = await _db.findOne(id);
    return item != null ? Transaction.fromMap(item) : null;
  }

  @override
  Future<void> insert(Transaction transaction) async {
    await _db.insert(transaction.toMap());
  }

  @override
  Future<void> update(Transaction transaction) async {
    await _db.update(transaction.toMap());
  }

  @override
  Future<void> delete(int id) async {
    await _db.remove(id);
  }
}}