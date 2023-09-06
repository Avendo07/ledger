import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  late bool isDebit;
  late String counterParty;
  late double amount;
  late DateTime timeStamp;
  static final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isDebit = true;
    counterParty = " "; //TODO: Might need some validators here using form field
    amount = 0;
    timeStamp = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add a transaction"),
          backgroundColor: Colors.white,
          //TODO: Change these colors to material you
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Card(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Credit"),
                      Switch(
                        onChanged: (bool value) {
                          setState(() {
                            isDebit = !isDebit;
                          });
                        },
                        value: isDebit,
                      ),
                      const Text("Debit"),
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Counter party"),
                    ),
                    onChanged: (value) => counterParty = value,
                    initialValue: counterParty,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Amount"),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      //TODO: How does this work
                      FilteringTextInputFormatter(RegExp(r'(^\d*\.?\d*)'),
                          allow: true),
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: true),
                    initialValue: amount.toString(),
                    onChanged: (value) => amount = double.parse(value),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Date n Time"),
                    ),
                    onChanged: (value) => timeStamp = DateTime.parse(value),
                  ),
                  // const TextField()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
