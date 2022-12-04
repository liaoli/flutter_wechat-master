import 'package:flutter/material.dart';
import 'package:wechat/color/colors.dart';


class ButtonRow extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final String text;
  final TextStyle style;
  final VoidCallback? onPressed;
  final bool isBorder;
  final double lineWidth;

  ButtonRow({
    this.margin,
    this.text="",
    this.style = const TextStyle(
        color: Colours.c_FF6073FF, fontWeight: FontWeight.w600, fontSize: 16),
    this.onPressed,
    this.isBorder = false,
    this.lineWidth = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        border: isBorder
            ? Border(
                bottom: BorderSide(color: Colors.transparent, width: lineWidth),
              )
            : null,
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        color: Colors.white,
        onPressed: onPressed ?? () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          alignment: Alignment.center,
          child: Text(text, style: style),
        ),
      ),
    );
  }
}
