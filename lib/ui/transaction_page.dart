import 'package:flutter/material.dart';
import 'package:ledger/model/transaction.dart';
import 'package:ledger/routing/named_routes.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(addTransactionPage),
            /*repo.insert(
                Transaction(TransactionType.debit, 500, DateTime.now(), "Helo",)),*/
            child: const Text("Add Transaction"),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(listTransactionPage),
            /*print(repo.getTransaction("0").toString()),*/
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
