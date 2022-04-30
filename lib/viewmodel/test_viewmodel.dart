import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ishonch_test/service/api.dart';
import 'package:ishonch_test/service/service.dart';

class TestViewModel extends ChangeNotifier {
  final textController = TextEditingController();
  final numberController = TextEditingController();
  Map<String, bool> empty = {};
  var items = [];
  var itemselect = {};
  List<Map<String, bool>> values = [];
  bool loading = false;
  void callTest(String id) async {
    loading = true;
    notifyListeners();
    var respons = await Network.postApi(Api.alltest, Api.testParams(id));
    if (!respons['error']) {
      items = respons['data']['data'];
      for (int i = 0; i < items.length; i++) {
        if (items[i]["type"] == "SimpleSelect") {
          itemselect.addAll({items[i]["id"]: ""});
        }
        if (items[i]["type"] == "Multiselect") { 
          values.addAll({items[i]["id"]: empty});
          for (int j = 0; j < items[i]['answer'].length; j++) {
            values[items[i]["id"]]?.addAll({items[i]["answer"][j]["text"]: false});
          }
        }
      }
    } else {
      items = [];
    }
    loading = false;
    notifyListeners();
  }

  void radioButton(String value, int index, int id) {
    for (int i = 0; i < items.length; i++) {
      if (items[i]["id"] == id) {
        itemselect[id] = value;
        notifyListeners();
      }
    }
  }

  void chekBox(bool value, String key, int id) {
    values[id]![key] = value;
    print(values);
    notifyListeners();
  }
}
