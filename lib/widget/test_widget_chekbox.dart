// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ishonch_test/funksion/colorhex.dart';
import 'package:ishonch_test/funksion/text.dart';

class TestWidgetChek extends StatelessWidget {
  const TestWidgetChek({
    Key? key,  required this.onchange, required this.values, required this.text,
    
  }) : super(key: key);
  
  final Map<String, bool> values;
  final Function onchange;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 10),
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
                  Column(
                    children: values.keys.map((String key) {
                      return SizedBox(
                        height: 35,
                        child: CheckboxListTile(
                          title: TextWidget.txt(key, 18, FontWeight.w500, ColorHex.colorFromHex("#000000")),
                          value: values[key],
                          onChanged: (value) {
                            onchange(value,key);
                          },
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
  }
}
