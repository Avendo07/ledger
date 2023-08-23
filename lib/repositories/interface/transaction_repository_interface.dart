import 'package:ledger/model/transaction.dart';

abstract class ITransactionRepository {
  List<Transaction> getAll();

  Transaction? getTransaction(String transactionId);

  void insert(Transaction transaction);

  void update(Transaction transaction);

  void delete(String transactionId);
}
