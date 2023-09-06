import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/ui/excel_export.dart';
import 'package:ledger/ui/message_sync.dart';
import 'package:ledger/ui/transaction_page.dart';
import 'package:ledger/view_model/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomBarIndex = 0;
  final _children = const [TransactionPage(), MessageList(), ExcelExport()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Ledger'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed("/settings"),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: _children[_bottomBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomBarIndex,
        onTap: (int index) => setState(() {
          _bottomBarIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_outlined),
            activeIcon: Icon(Icons.sync),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ios_share_outlined),
            activeIcon: Icon(Icons.ios_share),
            label: "Export",
          ),
        ],
      ),
    );
  }
}

class ExcelData extends GetView<HomeController> {
  const ExcelData({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (controller) => controller.loading.value
          ? const SizedBox(height: 30, child: CircularProgressIndicator())
          : controller.errorMsg != null
              ? Text(controller.errorMsg!)
              : Text(controller
                  .excel.sheets["December 2022"]!.rows[0].last!.value),
    );
    // return controller.obx(
    //     (state) => Text(state.excel.sheets["Sheet1"]!.rows[0].first!.value),
    //     onError: (String? error) => Text(error ?? ""),
    //     onLoading: CircularProgressIndicator());
  }
}
