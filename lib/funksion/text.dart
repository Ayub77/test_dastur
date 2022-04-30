import 'package:flutter/cupertino.dart';

class TextWidget{
  static Widget txt(String txt,double size,FontWeight fontweiht,Color color){
    return Text(txt,style: TextStyle(fontFamily: "Gilroy",fontSize: size,fontWeight:fontweiht,color: color),);
   }
}