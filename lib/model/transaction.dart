import 'package:ledger/constants/enum.dart';

class Transaction {
  final String transactionId;
  final TransactionType transactionType;

  // final String sender;
  // final String receiver;
  final int amount;
  final DateTime timeStamp;

  Transaction(
      this.transactionId, this.transactionType, this.amount, this.timeStamp);

  Transaction.fromMap(Map<String, dynamic> data)
      : transactionId = data['transactionId'],
        transactionType = data['transactionType'],
        amount = data['amount'],
        timeStamp = data['timeStamp'];

  Transaction.fromList(List<dynamic> data):
  transactionId = data[0],
  transactionType = data[1] as TransactionType,
  amount = data[2],
  timeStamp = data[3];

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'transactionType': transactionType,
      'amount': amount,
      'timeStamp': timeStamp
    };
  }
}