// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:bmi_calc/controllers/bmi_controller.dart';
import 'package:bmi_calc/models/bmi_model.dart';
import 'package:bmi_calc/screens/history_screen.dart';
import 'package:bmi_calc/widgets/custom_button.dart';
import 'package:bmi_calc/widgets/info_card.dart';
import 'package:flutter/material.dart';

import 'package:bmi_calc/utilities/consts.dart';
import 'package:bmi_calc/widgets/custom_icon_button.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final BMIController _bmiController = Get.find<BMIController>();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  saveresult() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String> bmiList1 = _bmiController.bmiModelList
        .map((item) => json.encode(BmiModel.toMap(item)))
        .toList();
    await sharedPreferences.setStringList('list', bmiList1);

    print(bmiList1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          color: backgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                        onPressed: () {
                          Get.back();
                        },
                        width: 45,
                        height: 45,
                        icon: Icons.arrow_back),
                    Text(
                      "BMI result",
                      style: TextStyle(
                          color: darkTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    CustomIconButton(
                        onPressed: () {
                          Get.to(History());
                        },
                        width: 45,
                        height: 45,
                        icon: Icons.archive),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: foregroundColor,
                  boxShadow: outerShadow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Obx(
                      () {
                        final String bmi =
                            _bmiController.bmi.toStringAsFixed(1);
                        final resultText = _bmiController.result.value;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Your BMI",
                              style: TextStyle(color: darkTextColor),
                            ),
                            Text(
                              bmi,
                              style:
                                  TextStyle(color: darkTextColor, fontSize: 48),
                            ),
                            Text(
                              resultText,
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: foregroundColor,
                  boxShadow: outerShadow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InfoCard(
                        lowerBMI: 'Less than 18.5',
                        bmiResult: 'Underweight',
                      ),
                      Divider(height: 40.0),
                      InfoCard(
                        lowerBMI: '18.5',
                        upperBMI: '24.5',
                        bmiResult: 'Normal',
                      ),
                      Divider(height: 40.0),
                      InfoCard(
                        lowerBMI: '25',
                        upperBMI: '29.5',
                        bmiResult: 'Overweight',
                      ),
                      Divider(height: 40.0),
                      InfoCard(
                        lowerBMI: 'More than 29.5',
                        bmiResult: 'Obesity',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              CustomButton(
                onPressed: () async {
                  saveresult();
                  _bmiController.addbmi(
                    BmiModel(
                        gender: _bmiController.getGender().toString(),
                        dateTime: formatted,
                        age: _bmiController.age.value,
                        bmi: _bmiController.bmi.toStringAsFixed(1),
                        resultText: _bmiController.result.value),
                  );

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return History();
                  }));
                },
                width: 200,
                text: 'Save Results',
                textColor: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xFF56D0DB),
                    Color(0xFF59C8E3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
