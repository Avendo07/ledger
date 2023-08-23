import 'dart:core';

import 'package:hive_flutter/hive_flutter.dart';
part 'enum.g.dart';

@HiveType(typeId: 2)
enum TransactionType {
  @HiveField(0)
  credit,

  @HiveField(1)
  debit
}

TransactionType? parseTransactionTypeFromString(String data) {
  for (TransactionType type in TransactionType.values) {
    if (type.name == data) {
      return type;
    }
  }
  return null;
}
