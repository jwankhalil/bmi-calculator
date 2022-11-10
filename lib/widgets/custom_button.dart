import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:bmi_calc/utilities/consts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final Color textColor;
  final Color? buttonColor;
  final String text;
   final LinearGradient gradient;
  const CustomButton({
    Key? key,
    required this.onPressed,
    this.width,
    required this.textColor,
    this.buttonColor,
    required this.text,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
          gradient: gradient,
          boxShadow: outerShadow,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
