import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ishonch_test/funksion/firetoast.dart';
import 'package:ishonch_test/pages/homepage.dart';
import 'package:ishonch_test/service/api.dart';
import 'package:ishonch_test/service/service.dart';

class LoginViewmodel extends ChangeNotifier {
  static var box = Hive.box("MyBaza");
  final loginController = TextEditingController();
  final parolController = TextEditingController();

  getlogin(context) async {
    String login = loginController.text.trim();
    String parol = parolController.text.trim();
    if (login == "" || parol == "") {
      Utils.firetoast("Ma'lumotlarni to'ldiring");
    } else {
      String basicAuth = "Basic " + base64Encode(utf8.encode('$login:$parol'));
      box.put('auth', null);
      box.put('auth', basicAuth);
      var res = await Network.getApi(Api.apiLogin, Api.emptyParams());
      if (!res['error']) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        box.put('auth', null);
        if(res['data']=="Server bilan aloqa yo'q"){
        Utils.firetoast("Bunday foydalanuvchi mavjud emas");
        }
      }
    }
  }
}
