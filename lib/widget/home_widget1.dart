// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ishonch_test/funksion/colorhex.dart';
import 'package:ishonch_test/funksion/text.dart';

class HomePAgeWidget1 extends StatelessWidget {
  const HomePAgeWidget1({
    Key? key,
    required this.ontab,
    this.items,
  }) : super(key: key);
  final Function ontab;
  final dynamic items;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 5,
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: Card(
        margin: EdgeInsets.all(0),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: InkWell(
          onTap: () {
            ontab(items);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
          
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                TextWidget.txt(items["title"], 15, FontWeight.w500,
                    ColorHex.colorFromHex("#000000")),
                TextWidget.txt(items["description"], 15, FontWeight.w500,
                    ColorHex.colorFromHex("#000000")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
