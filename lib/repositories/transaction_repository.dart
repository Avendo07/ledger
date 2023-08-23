import 'package:hive_flutter/hive_flutter.dart';
import 'package:ledger/constants/hive_box.dart' as constants;
import 'package:ledger/model/transaction.dart';
import 'package:ledger/repositories/interface/transaction_repository_interface.dart';

class TransactionRepository extends ITransactionRepository {
  late Box<Transaction> transactions;

  @override
  void delete(int id) {
    // TODO: implement delete
  }

  @override
  List<Transaction> getAll() {
    List<Transaction> list = [];
    try {
      initialiseBox();
      list = transactions.values.toList(growable: true);
    } catch (e) {
      rethrow;
    }
    return list;
  }

  @override
  Transaction? getOne(int id) {
    try {
      initialiseBox();
      return transactions.getAt(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void insert(Transaction transaction) {
    try {
      initialiseBox();
      transactions.add(transaction);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void update(Transaction transaction) {
    // TODO: implement update
  }

  void initialiseBox() {
    if (Hive.isBoxOpen(constants.transactionBox)) {
      transactions = Hive.box<Transaction>(constants.transactionBox);
    } else {
      Hive.openBox<Transaction>(constants.transactionBox);
      throw Exception("DB is not ready, try again in some time");
    }
  }
}
