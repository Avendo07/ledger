import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  bool isDebit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 0.5,
        child: Row(
          children: [
            const Text("Debit/Credit"),
            Switch(
              onChanged: (bool value) {
                setState(() {
                  isDebit = !isDebit;
                });
              },
              value: isDebit,
            ),
          ],
        ),
      ),
    );
  }
}
