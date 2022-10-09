enum TransactionType { credit, debit }

extension ParseToString on TransactionType{
  String toShortString() {
    return toString().split('.').last;
  }
}
