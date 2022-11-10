// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bmi_calc/screens/home_screen.dart';
import 'package:bmi_calc/utilities/consts.dart';
import 'package:bmi_calc/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool log = true;
  void checklog() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      log = (sharedPreferences.getBool("login") ?? true);
    });
    if (log == false) {
      Get.to(HomeScreen());
    }
  }

  savename(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("name", name);
    sharedPreferences.setBool("login", true);
  }

  @override
  void initState() {
    checklog();
    super.initState();
  }

  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bmi Calculator",
                style: TextStyle(color: darkTextColor, fontSize: 45),
              ),
              Form(
                child: TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(
                    // labelText: "Name",
                    hintText: "name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // savename(value);
                    name = value;
                  },
                  validator: (value) {
                    return value!.isEmpty ? "Please enter youe name" : null;
                  },
                ),
              ),
              CustomButton(
                onPressed: () async {
                  savename(name);
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setBool("login", false);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
                textColor: Colors.white,
                width: double.infinity,
                text: "Login",
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
