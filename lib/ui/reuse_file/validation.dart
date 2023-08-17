import 'package:flutter/material.dart';

class Validation extends StatelessWidget {
  final IconData? icon;
  final String? textValidate;
  final TextStyle? textStyle;
  final CrossAxisAlignment? crossAxisAlignment;

  // ignore: use_key_in_widget_constructors
  const Validation(
      {this.icon, this.textValidate, this.textStyle, this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 0,
                  child: Icon(
                    icon,
                    color: Colors.red,
                    size: 20,
                  )),
              Expanded(
                  flex: 1,
                  child: Text(' $textValidate',
                      style: textStyle ??
                          const TextStyle(fontSize: 14 ,color: Colors.red)))
            ],
          )
        : Row(
            children: [
              Text(' $textValidate',
                  style: textStyle ??
                      const TextStyle(fontSize: 14 ,color: Colors.red)),
            ],
          );
  }
}
