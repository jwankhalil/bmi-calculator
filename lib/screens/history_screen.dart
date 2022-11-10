// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:bmi_calc/models/bmi_model.dart';
import 'package:bmi_calc/utilities/consts.dart';
import 'package:bmi_calc/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var bmi;
  var name;
  List<BmiModel> listItems = <BmiModel>[];
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? bmiList = sharedPreferences.getStringList('list');
    listItems =
        bmiList!.map((item) => BmiModel.fromJson(json.decode(item))).toList();
    name = sharedPreferences.getString("name");
    setState(() {
      List<String>? bmiList = sharedPreferences.getStringList('list');
      listItems =
          bmiList!.map((item) => BmiModel.fromJson(json.decode(item))).toList();
      name = sharedPreferences.getString("name");
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: 45,
                        height: 45,
                        icon: Icons.arrow_back),
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "History",
                      style: TextStyle(
                          color: darkTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: listItems.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 150,
                          decoration: BoxDecoration(
                            color: foregroundColor,
                            boxShadow: outerShadow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "$name",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: darkTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "Gender: ${listItems[index].gender.toString()}",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: darkTextColor,
                                ),
                              ),
                              Text(
                                "Age: ${listItems[index].age.toString()}",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: darkTextColor,
                                ),
                              ),
                              Text(
                                "bmi: ${listItems[index].bmi.toString()}",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: darkTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "${listItems[index].dateTime.toString()}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: lightTextColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
