import 'package:flutter_test/flutter_test.dart';

void main() {
  group("trials", () {
    test("Date Time", () {
      DateTime time = DateTime.now();
      print(time.toString());
      print("String".startsWith("St"));
    });

    Map<String, String> matcher(String template, String data) {
      List templateList = template.split(" ");
      List dataList = data.split(" ");
      Map<String, String> extractedData = {};
      String templateVar = "";
      String buffer = "";
      for (int tempIndex = 0, dataIndex = 0; tempIndex < templateList.length;) {
        if (templateList[tempIndex].startsWith("/@")) {
          if(buffer!=""){
            extractedData[templateVar] = buffer;
            buffer = "";
          } else {
            print("${templateList[tempIndex]}: ${dataList[dataIndex]}/@\n");
            buffer = dataList[dataIndex];
            templateVar = templateList[tempIndex];
          }
          dataIndex++;
          tempIndex++;
        } else {
          if (templateList[tempIndex] == dataList[dataIndex]) {
            print("${templateList[tempIndex]}: ${dataList[dataIndex]}==\n");
            if (buffer != "") {
              extractedData[templateVar] = buffer;
              buffer = "";
            }
            dataIndex++;
            tempIndex++;
          } else {
            buffer = buffer + " " + dataList[dataIndex];
            extractedData[templateList[tempIndex]] = dataList[dataIndex];
            print("${templateList[tempIndex]}: ${dataList[dataIndex]}!=\n");
            dataIndex++;
          }
        }
        /*if (templateList[tempIndex] == dataList[dataIndex]) {
          print("${templateList[tempIndex]}: ${dataList[dataIndex]}==\n");
          if(buffer != ""){
            extractedData[templateList[tempIndex]] = buffer;
            buffer = "";
          }
          dataIndex++;
          tempIndex++;
        } else {
          buffer = buffer + dataList[dataIndex];
          extractedData[templateList[tempIndex]] = dataList[dataIndex];
          print("${templateList[tempIndex]}: ${dataList[dataIndex]}!=\n");
          dataIndex++;
        }*/
      }
      return extractedData;
    }

    test("diff_match_patch 1 ", () {
      String mainString = "Hello Naman spent Rs 100 on 21 August";
      String template = "Hello /@name spent Rs /@amount on /@date";
      Map<String, String> differences = matcher(template, mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });

    test("diff_match_patch 2", () {
      String mainString = "Hello Naman spent Rs 100 on 21 August at 10 AM";
      String template = "Hello /@name spent Rs /@amount on /@date at /@time";
      Map<String, String> differences = matcher(template, mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });

    test("diff_match_patch 3", () {
      String mainString = "Hello Naman spent Rs 100 on 21 August at 10 AM time";
      String template =
          "Hello /@name spent Rs /@amount on /@date at /@time time";
      Map<String, String> differences = matcher(template, mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });

    test("diff_match_patch 4", () {
      String mainString = "Hello Naman spent Rs 100 on 21 August at 10 AM tim";
      String template =
          "Hello /@name spent Rs /@amount on /@date at /@time tim";
      Map<String, String> differences = matcher(template, mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });

    test("diff_match_pathch 5", () {
      String mainString = "Hello Naman 100 on 21 August at 10 AM tim";
      String template = "Hello /@name /@amount on /@date at /@time tim";
      Map<String, String> differences = matcher(template, mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });
  });
}
