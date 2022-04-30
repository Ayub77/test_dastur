import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ishonch_test/service/api.dart';
import 'package:ishonch_test/service/service.dart';

class AllTestModel extends ChangeNotifier {
  var items=[];
  bool loading = false;
  getAllTest() async {
    loading = true;
    notifyListeners();
    var respons = await Network.postApi(Api.test, Api.emptyParams());
    if (!respons["error"]) {
      items = respons['data']['data'];
    }else{
      items = [];
    }
    loading = false;
    notifyListeners();
  }
}
