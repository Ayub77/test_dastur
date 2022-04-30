import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ishonch_test/service/api.dart';
import 'package:ishonch_test/service/service.dart';

class TestViewModel extends ChangeNotifier {
  final textController = TextEditingController();
  final numberController = TextEditingController();
  static var box = Hive.box("MyBaza");
  var items = [];
  var itemselect = {};
  List values = [];
  Map<int, TextEditingController> controller = {};
  var choose = {};
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
          Map<String, bool> empty = {};
          for (int j = 0; j < items[i]["answer"].length; j++) {
            empty.addAll({items[i]["answer"][j]["text"]: false});
          }
          choose.addAll({
            items[i]['id'].toString(): empty,
          });
        }
        if (items[i]["type"] == "Written" || items[i]["type"] == "Number") {
          final textController = TextEditingController();
          controller.addAll({items[i]["id"]: textController});
        }
      }
    } else {
      items = [];
    }
    loading = false;
    notifyListeners();
  }

  void radioButton(String value, int index, int id) async {
    var data = await box.get("request");
    for (int i = 0; i < items.length; i++) {
      if (items[i]["id"] == id) {
        if (data == null) {
          int ans_id = 0;
          for (int j = 0; j < items[i]["answer"].length; j++) {
            if (items[i]["answer"][j]["text"] == value) {
              ans_id = items[i]["answer"][j]["id"];
            }
          }
          var requs = {
            "answer_id": [ans_id],
            "question_id": items[i]["id"]
          };
          var request = {
            "answer": [requs]
          };
          box.put("request", jsonEncode(request));
          break;
        } else {
          var reqqq = jsonDecode(data);
          for (int q = 0; q < reqqq["answer"].length; q++) {
            int ans_id = 0;
            for (int k = 0; k < items.length; k++) {
              for (int j = 0; j < items[k]["answer"].length; j++) {
                if (items[k]["answer"][j]["text"] == value) {
                  ans_id = items[k]["answer"][j]["id"];
                }
              }
            }
            if (reqqq["answer"][q]["question_id"] == id) {
              reqqq["answer"][q]["answer_id"].clear();
              reqqq["answer"][q]["answer_id"] = [ans_id];
              box.put("request", null);
              box.put("request", jsonEncode(reqqq));
              break;
            } else {
              bool choose = true;
              for (int z = 0; z < reqqq["answer"].length; z++) {
                if (reqqq["answer"][z]["question_id"] == id) {
                  choose = false;
                  break;
                }
              }

              if (choose) {
                var requs = {
                  "answer_id": [ans_id],
                  "question_id": id
                };
                reqqq["answer"].add(requs);
                box.put("request", null);
                box.put("request", jsonEncode(reqqq));
                break;
              }
            }
          }
        }
        itemselect[id] = value;
        var daata = await box.get("request");
        var res = jsonDecode(daata);
        print(res);
        notifyListeners();
      }
    }
  }

  void chekBox(bool value, String key, int id) async {
    var data = await box.get("request");
    choose[id.toString()][key] = value;
    List reqKey = [];
    if (value) {
      for (int i = 0; i < items.length; i++){
        if (items[i]["id"] == id) {
          if (data == null){
            for (int k = 0; k < items[i]["answer"].length; k++) {
              if (items[i]["answer"][k]["text"] == key) {
                reqKey.add(items[i]["answer"][k]["id"]);
              }
            }
            var requs = {"answer_id": reqKey, "question_id": items[i]["id"]};
            var request = {
              "answer": [requs]
            };
            box.put("request", null);
            box.put("request", jsonEncode(request));
          } else {
            var reqq = jsonDecode(data);
            var reqq1 = jsonDecode(data);
            for (int j = 0; j < reqq1["answer"].length; j++) {
              if (reqq["answer"][j]["question_id"] == id){
                int addddd =0;
                for (int k = 0; k < items[i]["answer"].length; k++) {
                  if (items[i]["answer"][k]["text"] == key) {
                    addddd=items[i]["answer"][k]["id"];
                  }
                }
                reqq["answer"][j]["answer_id"].add(addddd);
                box.put("request", null);
                box.put("request", jsonEncode(reqq));
              }else{
                if(j==reqq1["answer"].length-1){
                  for (int k = 0; k < items[i]["answer"].length; k++) {
                  if (items[i]["answer"][k]["text"] == key) {
                    reqKey.add(items[i]["answer"][k]["id"]);
                  }
                }
                var requs = {
                  "answer_id": reqKey,
                  "question_id": items[i]["id"]
                };
                reqq["answer"].add(requs);
                box.put("request", null);
                box.put("request", jsonEncode(reqq));
                }
              }
            }
          }
        }
      }
    } else {
      var ress = jsonDecode(data);
      for (int i = 0; i < items.length; i++) {
        if (items[i]["id"] == id) {
          for (int k = 0; k < items[i]["answer"].length; k++) {
            if (items[i]["answer"][k]["text"] == key) {
              for (int f = 0; f < ress["answer"].length; f++) {
                if (ress["answer"][f]["question_id"] == id) {
                  ress["answer"][f]["answer_id"].removeWhere((item) => item == items[i]["answer"][k]["id"]);
                }
              }
            }
          }
        }
      }
      box.put("request", null);
      box.put("request", jsonEncode(ress));
    }
    var daataqqqq = await box.get("request");
    var res = jsonDecode(daataqqqq);
    print(res);
    
    notifyListeners();
  }
}
