// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ishonch_test/funksion/colorhex.dart';
import 'package:ishonch_test/funksion/text.dart';
import 'package:ishonch_test/pages/test_page.dart';
import 'package:ishonch_test/viewmodel/alltest_viewmodel.dart';
import 'package:ishonch_test/widget/home_widget1.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllTestModel viewnodel = AllTestModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewnodel.getAllTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHex.colorFromHex("#E5E5E5"),
      appBar: AppBar(
        title: TextWidget.txt("Testlar to'plami", 18, FontWeight.w600, ColorHex.colorFromHex("#FFFFFF")),
        backgroundColor: ColorHex.colorFromHex("#2755A5"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewnodel,
        child: Consumer<AllTestModel>(
          builder: (context, model, index) {
            return Stack(
              children: [
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListView.builder(
                        itemCount: viewnodel.items.length,
                        itemBuilder: (context, index) {
                          return HomePAgeWidget1(
                            items: viewnodel.items[index],
                            ontab: (value) {Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestPage(id: value['id'].toString(),title: value['title'],)));
                          });
                        })),
                viewnodel.loading
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
        onPressed: () {},
      ),
    );
  }
}
