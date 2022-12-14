import 'package:bmi_calc/utilities/consts.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final lowerBMI;
  final upperBMI;
  final bmiResult;

  InfoCard({this.lowerBMI, this.upperBMI, this.bmiResult});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              lowerBMI.toString(),
              style: TextStyle(
                color: darkTextColor,
                fontSize: 18.0,
              ),
            ),
            upperBMI != null
                ? Text(
                    ' to ' + upperBMI.toString(),
                    style: TextStyle(
                      color: darkTextColor,
                      fontSize: 18.0,
                    ),
                  )
                : Text(''),
          ],
        ),
        Text(
          bmiResult.toString(),
          style: TextStyle(
            color: darkTextColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
