import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:bmi_calc/utilities/consts.dart';
import 'package:bmi_calc/widgets/custom_icon_button.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.text,
      required this.increment,
      required this.decrement,
      required this.number})
      : super(key: key);
  final String text;
  final VoidCallback increment;
  final VoidCallback decrement;
  final  number;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: foregroundColor,
        boxShadow: outerShadow,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: TextStyle(color: lightTextColor,fontSize: 22),
          ),
          Text(
            "$number",
            style: TextStyle(color: Colors.black54, fontSize: 36),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconButton(
                  onPressed: increment, width: 40, height: 40, icon: Icons.add),
                  CustomIconButton(
                  onPressed: decrement, width: 40, height: 40, icon: Icons.remove),
            ],
          )
        ],
      ),
    );
  }
}
