// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TestWidgetText extends StatelessWidget {
  const TestWidgetText({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

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
          Text("savol joylashuvi"),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: Colors.blueAccent)),
                  padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
