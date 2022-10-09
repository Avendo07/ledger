import 'package:ledger/model/transaction.dart';

abstract class ITransactionRepository {
  Future<List<Transaction>> getAll();

  Future<Transaction?> getOne(int id);

  Future<void> insert(Transaction book);

  Future<void> update(Transaction book);

  Future<void> delete(int id);
}
