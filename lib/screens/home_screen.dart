// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:bmi_calc/controllers/bmi_controller.dart';
import 'package:bmi_calc/screens/history_screen.dart';
import 'package:bmi_calc/screens/result_screen.dart';
import 'package:bmi_calc/utilities/consts.dart';
import 'package:bmi_calc/widgets/custom_button.dart';
import 'package:bmi_calc/widgets/custom_card.dart';
import 'package:bmi_calc/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
var name;

  bool isSignIn = false;

  final BMIController _bmiController = Get.put(BMIController());

  void _calculateBMIShowResult(BuildContext context) {
    _bmiController.calculateBMI();
    final bmi = _bmiController.bmi;
  }

    getNamePref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString("name");
    
    if (name != null) {
      setState(() {
        name = sharedPreferences.getString("name");
       
      });
    }
  }
  @override
  void initState() {
    getNamePref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: backgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Hi ${name}",
                        style: TextStyle(
                            color: darkTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomIconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return History();
                          }));
                        },
                        width: 45,
                        height: 45,
                        icon: Icons.archive)
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Obx(() {
                final selectedGender =_bmiController.selectedGender.value;
                return Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          _bmiController.selectedGender(Gender.male);
                        },
                        textColor: selectedGender == Gender.male
                            ? Colors.white
                            : lightTextColor,
                        text: "Male",
                        gradient: selectedGender == Gender.male
                            ? LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Color(0xFF56D0DB),
                                  Color(0xFF59C8E3),
                                ],
                              )
                            : LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Color(0xFFF0EEF3),
                                  Color(0xFFF0EEF3),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          _bmiController.selectedGender(Gender.female);
                        },
                        textColor: selectedGender == Gender.female
                            ? Colors.white
                            : lightTextColor,
                        text: "FeMale",
                        gradient: selectedGender == Gender.female
                            ? LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Color(0xFF56D0DB),
                                  Color(0xFF59C8E3),
                                ],
                              )
                            : LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Color(0xFFF0EEF3),
                                  Color(0xFFF0EEF3),
                                ],
                              ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 20.0),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: 50,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: foregroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: outerShadow,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Height',
                              style: TextStyle(
                                fontSize: 22,
                                color: lightTextColor,
                              ),
                            ),
                            Transform.rotate(
                              angle: 3 * pi / 2,
                              child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Colors.white70,
                                    activeTrackColor:
                                        Theme.of(context).accentColor,
                                    inactiveTrackColor: Colors.black12,
                                  ),
                                  child: Obx(
                                    () {
                                      return Slider(
                                        divisions: 230,
                                       
                                        value: _bmiController.height.value
                                            .toDouble(),
                                        min: 110.0,
                                        max: 230.0,
                                        onChanged: (value) {
                                          
                                          _bmiController.height.value =
                                              value.toInt();
                                          // setState(() {
                                          //   height = value;
                                          // });
                                        },
                                      );
                                    },
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Obx(() {
                                  return Text(
                                    "${_bmiController.height.value}",
                                    style: TextStyle(
                                      color: darkTextColor,
                                      fontSize: 36.0,
                                    ),
                                  );
                                }),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, bottom: 8.0),
                                  child: Text(
                                    'cm',
                                    style: TextStyle(
                                      color: lightTextColor,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: Column(
                          children: [
                            Expanded(
                              child: Obx(
                                () {
                                  return CustomCard(
                                    text: "Weghit",
                                    number: _bmiController.weight.value,
                                    increment: () {
                                      _bmiController.increaseWeightt();
                                    },
                                    decrement: () {
                                      _bmiController.decreaseWeight();
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Obx(() {
                                return CustomCard(
                                  text: "Age",
                                  number: _bmiController.age.value,
                                  //_bmiController.age.value,
                                  increment: () {
                                    _bmiController.increaseAge();
                                  },
                                  decrement: () {
                                    _bmiController.decreaseAge();
                                  },
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                onPressed: () {
                  if (_bmiController.selectedGender != null) {
                    _bmiController.calculateBMI();
                    Get.to(ResultScreen());
       
                  }
                },
                textColor: Colors.white,
                width: double.infinity,
                text: "Calculate",
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xFF56D0DB),
                    Color(0xFF59C8E3),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
