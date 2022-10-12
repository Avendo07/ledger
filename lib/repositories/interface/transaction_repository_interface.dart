import 'package:ledger/model/transaction.dart';

abstract class ITransactionRepository {
  List<Transaction> getAll();

  Transaction? getOne(int id);

  void insert(Transaction transaction);

  void update(Transaction transaction);

  void delete(int id);
}
