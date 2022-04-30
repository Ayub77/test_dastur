// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:ishonch_test/funksion/colorhex.dart';
import 'package:ishonch_test/funksion/text.dart';

class TestWidgetRadio extends StatelessWidget {
  const TestWidgetRadio({
    Key? key, required this.verticalGroupValue, required this.status, required this.onchange, required this.text,
    
  }) : super(key: key);
  final String text;
  final String verticalGroupValue;
  final List<String> status;
  final Function onchange;

  @override
  Widget build(BuildContext context) {
    return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 5,
                        color: Colors.grey.withOpacity(0.2))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget.txt(text, 20, FontWeight.w500, ColorHex.colorFromHex("#000000")),
                  SizedBox(
                    height: 20,
                  ),
                  RadioGroup<String>.builder(
                    groupValue: verticalGroupValue,
                    textStyle: TextStyle(fontSize: 18,fontFamily: "Gilroy",fontWeight: FontWeight.w500),
                    onChanged: (value){
                      onchange(value);
                    },
                    items: status,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),
                ],
              ),
            );
  }
}
