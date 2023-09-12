import 'package:hive_flutter/adapters.dart';
import 'package:ledger/model/transaction.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject {
  @HiveField(1)
  final String bankName;

  @HiveField(2)
  final String? nickName;

  @HiveField(3)
  final List<Transaction> transactions;

  Account({required this.transactions, required this.bankName, this.nickName});
//AccountType accountType;

//TODO: Add toMap and fromMap
}
