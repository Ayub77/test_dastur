import 'package:fluttertoast/fluttertoast.dart';
import 'package:ishonch_test/funksion/colorhex.dart';

class Utils {
  static void firetoast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorHex.colorFromHex("#8896A1"),
        textColor: ColorHex.colorFromHex("##FFFFFF"),
        fontSize: 16.0);
  }
}