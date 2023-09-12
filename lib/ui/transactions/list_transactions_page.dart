import 'package:flutter/material.dart';
import 'package:ledger/constants/enum.dart';
import 'package:ledger/model/transaction.dart';
import 'package:ledger/repositories/transaction_repository.dart';
import 'package:ledger/utility/date_time_utility.dart';

class ListTransactionsPage extends StatelessWidget {
  const ListTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionRepository repo = TransactionRepository();
    List<Transaction> transactions = repo.getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(transactions[index].counterParty),
          subtitle: Text(
            formatTimeStampString(transactions[index].timeStamp),
          ),
          trailing: Text(
            transactions[index].amount.toString(),
            style: TextStyle(
                color:
                    transactions[index].transactionType == TransactionType.debit
                        ? Colors.red
                        : Colors.green),
          ),
        ),
        itemCount: transactions.length,
        prototypeItem: ListTile(
          title: Text(transactions.first.counterParty),
          subtitle: Text(
            formatTimeStampString(transactions.first.timeStamp),
          ),
          trailing: Text(
            transactions.first.amount.toString(),
          ),
        ),
      ),
    );
  }
}
