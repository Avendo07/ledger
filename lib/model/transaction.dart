import 'package:hive_flutter/adapters.dart';
import 'package:ledger/constants/enum.dart';
import 'package:ledger/utility/date_time_utility.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  // @HiveField(0)
  // final String transactionId;

  @HiveField(1)
  final TransactionType transactionType;

  @HiveField(2, defaultValue: "")
  final String counterParty;

  @HiveField(4)
  final double amount;

  @HiveField(5)
  final DateTime timeStamp;

  // @HiveField(6)
  // final String sender;
  //
  // @HiveField(7)
  // final String receiver;

  Transaction(
      {required this.transactionType,
      required this.amount,
      required this.timeStamp,
      required this.counterParty});

  Map<String, dynamic> toMap() {
    return {
      'transactionType': transactionType.name,
      'counterParty': counterParty,
      'amount': amount,
      'timeStamp': formatTimeStampString(timeStamp)
    };
  }

  Transaction.fromMap(Map<String, dynamic> data)
      : transactionType = data['transactionType'],
        counterParty = data['counterParty'],
        amount = data['amount'],
        timeStamp = timeStampFromString(data['timeStamp']);

  /*Transaction.fromList(List<dynamic> data)                                    //TODO: These methods are for Excel extension
      :
        transactionType =
            parseTransactionTypeFromString(data[1]) ?? TransactionType.debit,
        amount = data[2],
        timeStamp = _timeStampFromString(data[3]);*/

  /*List<dynamic> toList() {
    return [
      transactionType.name,
      amount,
      _formatTimeStampString(timeStamp)
    ];
  }*/

  @override
  String toString() {
    return ("type: $transactionType, amount: $amount, time: $timeStamp, counterParty: $counterParty");
  }
}
