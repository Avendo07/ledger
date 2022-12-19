import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:ledger/services/excel_service/excel_service.dart';

class HomeController extends GetxController with StateMixin{
  late Excel excel;
  late RxBool loading = false.obs;
  String? errorMsg;
  @override
  void onInit() async {
    loading.toggle();
    await ExcelService.readExcelSheet().then((value) {
      loading.toggle();
      if(value!=null){
        excel = value;
        print("done");
        print(value.sheets.length);
        print("printed");
      }else{
        // throw Exception("Hello, excel is not available");
        errorMsg = "Hello, excel is not available";
      }
    }).onError((error, stackTrace){
      print("Error $error");
      errorMsg = "Couldn't load excel";
    });
    print("Done");
    super.onInit();
  }
}