// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ishonch_test/funksion/colorhex.dart';
import 'package:ishonch_test/funksion/text.dart';

class TestWidgetText extends StatelessWidget {
  const TestWidgetText({
    Key? key,
    required this.textController, required this.text, required this.type,
  }) : super(key: key);

  final TextEditingController textController;
   final String text;
   final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10,top: 5),
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
          Container(
            width: double.infinity,
            height: 35,
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: Colors.blueAccent)),
                  padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: textController,
              keyboardType: type=="Written"?TextInputType.text:TextInputType.number,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
