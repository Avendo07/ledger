import 'dart:core';

enum TransactionType { credit, debit }

TransactionType? parseTransactionTypeFromString(String data) {
  for (TransactionType type in TransactionType.values) {
    if (type.name == data) {
      return type;
    }
  }
  return null;
}
