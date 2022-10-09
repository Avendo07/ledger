import 'package:flutter_test/flutter_test.dart';

void main() {
  group("trials", () {
    test("Date Time", () {
      DateTime time = DateTime.now();
      print(time.toString());
      print("String".startsWith("St"));
    });

    Map<String, String> matcher(String template, String data) {
      List<String> tempList = template.split("/@");
      List<String> dataList = data.split(" ");
      Map<String, String> extractedData = {};
      int sumYet = 0;
      print(tempList);
      for (int index = 0; index < tempList.length - 1; index++) {
        print(dataList);
        List<String> tempSubList = tempList[index + 1].split(" ");
        tempSubList.removeWhere((element) => element == "");
        List<String> prevTempSubList = tempList[index].split(" ");
        prevTempSubList.removeWhere((element) => element == "");
        int position = dataList.indexOf(prevTempSubList.last) + 1;
        // print(tempSubList[1]);
        int endPosition;
        if (tempSubList.length == 1) {
          //Move from here
          endPosition = dataList.length;
        } else {
          endPosition = dataList.indexOf(tempSubList[1]);
        }
        print("$position $endPosition $prevTempSubList $index $sumYet");
        String finalString = dataList
            .getRange(position, endPosition)
            .fold("", (value, e) => "$value $e");
        extractedData[tempSubList[0]] = finalString;
        sumYet = sumYet + prevTempSubList.length;
      }
      return extractedData;

      /*String templateVar = "";                                                //V2
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
        }*/
      /*if (templateList[tempIndex] == dataList[dataIndex]) {                 V1
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

      return extractedData;
    }

    RegExp generateRegex(String template) {
      RegExp reg = RegExp(r'\/\@.\w+\b');
      String newString = template.replaceAll(reg, ".*");
      return RegExp(newString);
    }

    Map<String, String> templateMatcher(String string) {
      String template1 = "Hello /@name spent Rs /@amount on /@date at /@time";
      String template2 = "Hello /@name works /@time hours";
      List<String> templates = [template1, template2];
      Map<String, String> outputMap = {};
      for (var template in templates) {
        RegExp reg = generateRegex(template);
        if (reg.hasMatch(string)) {
          return matcher(template, string);
        }
      }
      return outputMap;

      /*for (String template in templates) {
        RegExp regex = RegExp(template.replaceAll(RegExp(r'/@.*'), '.*'));
        print("Selected regex $regex");
        if (regex.hasMatch(string)) {
          matcher(template, string);
        }
      }
      return outputMap;*/
    }

    test("diff_match_patch 1 ", () {
      String mainString = "Hello Naman spent Rs 100 on 21 August here";
      String template = "Hello /@name spent Rs /@amount on /@date here";
      Map<String, String> differences = matcher(template, mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });

    test("diff_match_patch 2", () {
      String mainString = "Hello Naman spent Rs 100 on 21 August at 10 AM";
      String template = "Hello /@name spent Rs /@amount on /@date at /@time";
      Map<String, String> differences = templateMatcher(mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });

    test("diff_match_patch 3", () {
      String mainString =
          "Hello Naman spent Rs 100 on 21 August at 10 AM time in Delhi place";
      String template =
          "Hello /@name spent Rs /@amount on /@date at /@time time in /@place place";
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

    test("diff_match_pathch 6", () {
      String mainString = "Hello Naman 100 on 21 at August at 10 AM tim";
      String template = "Hello /@name /@amount on /@date at /@time at tim";
      Map<String, String> differences = matcher(template, mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });

    test("diff_match_pathch 7", () {
      String mainString = "Hello Naman works 19 hours";
      Map<String, String> differences = templateMatcher(mainString);
      //List<Diff> differences = diff(template, mainString);
      print(differences);
    });

    test("reg ex", () {
      // RegExp reg = RegExp(r'Hello * how are you');
      // print(reg.hasMatch('Hello naman how are you'));
      // print(reg);

      var string = 'Humming is a bird';
      var regExp = RegExp(r'Humming .* bird');
      var match = regExp.hasMatch(string);
      // regExp.stringMatch(input)
      print(match);
    });

    test("Convert template to regex", () {
      String template = "Hello /@name earned /@amount on Monday";
      RegExp regex = generateRegex(template);
      RegExp expextedRegex = RegExp(r'Hello ./* earned ./* on Monday');
      print(regex.pattern);
    });
  });
}
