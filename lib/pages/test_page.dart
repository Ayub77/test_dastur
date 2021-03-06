// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ishonch_test/funksion/colorhex.dart';
import 'package:ishonch_test/funksion/firetoast.dart';
import 'package:ishonch_test/funksion/text.dart';
import 'package:ishonch_test/service/api.dart';
import 'package:ishonch_test/service/service.dart';
import 'package:ishonch_test/viewmodel/test_viewmodel.dart';
import 'package:ishonch_test/widget/test_widget_chekbox.dart';
import 'package:ishonch_test/widget/test_widget_radio.dart';
import 'package:ishonch_test/widget/test_widget_text.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key, required this.id, required this.title})
      : super(key: key);
  final String id;
  final String title;
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TestViewModel viewmodel = TestViewModel();
  static var box = Hive.box("MyBaza");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel.callTest(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorHex.colorFromHex("#E5E5E5"),
        appBar: AppBar(
          backgroundColor: ColorHex.colorFromHex("#2755A5"),
          title: TextWidget.txt(widget.title, 18, FontWeight.w600,
              ColorHex.colorFromHex("#FFFFFF")),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider(
          create: (context) => viewmodel,
          child: Consumer<TestViewModel>(
            builder: (context, index, model) {
              return Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                    child: ListView.builder(
                        itemCount: viewmodel.items.length,
                        itemBuilder: (context, index) {
                          return window(viewmodel.items[index]);
                        }),
                  ),
                  viewmodel.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox.shrink()
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: ColorHex.colorFromHex("#2755A5"),
        child: Icon(Icons.play_circle_outline_outlined),
        onPressed: ()async{
          var data = await box.get("request");
          if(data==null){
            Utils.firetoast("Siz hali testlarni bajarmadingiz");
          }else{
            var ans = jsonDecode(data); 
            Map<String,dynamic> params = {
              "test_id":widget.id,
               "answer":ans["answer"]
            };
           var respons = await Network.postApiJson(Api.result, params); 
           print(respons);
          }
        },
      ),
        );
  }

  Widget window(var item) {
    if (item["type"] == "SimpleSelect") {
      List<String> items = [];
      int index = 0;
      for (int i = 0; i < item["answer"].length; i++) {
        items.add(item["answer"][i]["text"]);
      }
      for (int i = 0; i < viewmodel.itemselect.length; i++) {
        for (int j = 0; j < items.length; j++) {
          if (viewmodel.itemselect[i] == items[j]) {
            index = i;
            break;
          }
        }
      }
      return TestWidgetRadio(
          text: item['text'],
          verticalGroupValue: viewmodel.itemselect[item['id']],
          status: items,
          onchange: (value) {
            viewmodel.radioButton(value, index, item['id']);
          });
    }
    if (item["type"] == "Multiselect") {
      return TestWidgetChek(
          text: item['text'],
          onchange: (value, key) {
            viewmodel.chekBox(value, key, item["id"]);
          },
          values: viewmodel.choose[item['id'].toString()]);
    }
    if (item["type"] == "Written" || item["type"] == "Number") {
      return TestWidgetText(
        type: item["type"],
         text: item['text'],
         textController: viewmodel.controller[item['id']] as TextEditingController);
    }

    return Container();
  }
}
