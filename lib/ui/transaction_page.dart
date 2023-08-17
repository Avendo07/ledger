import 'package:flutter/material.dart';
import 'package:ledger/constants/enum.dart';
import 'package:ledger/model/transaction.dart';
import 'package:ledger/repositories/transaction_repository.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionRepository repo = TransactionRepository();
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => repo.insert(
                Transaction("5", TransactionType.credit, 500, DateTime.now())),
            child: const Text("Add Transaction"),
          ),
          ElevatedButton(
            onPressed: () => print(repo.getOne(0).toString()),
            child: const Text("Print Transaction"),
          ),
        ],
      ),
    );
  }
}

void addTransaction(Transaction transaction) {
  print(transaction.toString());
}
