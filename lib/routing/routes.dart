import 'package:flutter/cupertino.dart';
import 'package:ledger/ui/homepage.dart';
import 'package:ledger/ui/settings.dart';
import 'package:ledger/ui/transactions/add_transaction_page.dart';
import 'package:ledger/ui/transactions/list_transactions_page.dart';

typedef Route = Widget Function(BuildContext);

Map<String, Route> routes = {
  "/home": (buildContext) => const HomePage(),
  "/settings": (buildContext) => Settings(),
  "/addTransaction": (buildContext) => const AddTransactionPage(),
  "/listTransaction": (buildContext) => const ListTransactionsPage()
};
