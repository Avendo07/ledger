import 'package:flutter/material.dart';
import 'package:ledger/constants/enum.dart';
import 'package:ledger/model/transaction.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => addTransaction(
            Transaction("5", TransactionType.credit, 500, DateTime.now())),
        child: const Text("Add Transaction"),
      ),
    );
  }
}

void addTransaction(Transaction transaction) {
  print(transaction.toString());
}
