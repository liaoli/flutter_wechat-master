import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../color/colors.dart';

class LabelRow extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double labelWidth;
  final bool isRight;
  final bool isLine;
  final String value;
  final String rValue;
  final Widget? rightW;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final Widget headW;
  final double lineWidth;

  LabelRow({
    required this.label,
    required this.onPressed,
    this.value = "",
    this.labelWidth = 0,
    this.isRight = true,
    this.isLine = false,
    this.rightW,
    this.rValue = "",
    this.margin,
    this.padding = const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 5.0),
    this.headW = const SizedBox(),
    this.lineWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:  FlatButton(
        color: Colors.white,
        padding: EdgeInsets.all(0),
        onPressed: onPressed ?? () {},
        child:  Container(
          padding: padding,
          margin: EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            border: isLine
                ? Border(
                    bottom:
                        BorderSide(color: Colours.c_FFE8E8E8, width: lineWidth))
                : null,
          ),
          child:  Row(
            children: <Widget>[
              if (headW != null) headW,
               SizedBox(
                child:  Text(
                  label ?? '',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
              value != null
                  ?  Text(value,
                      style: TextStyle(
                        color: Colours.c_FFC0C0C0,
                      ),)
                  :  Container(),
               Spacer(),
              rValue != null
                  ?  Text(rValue,
                      style: TextStyle(
                          color: Colours.c_FFE8E8E8,
                          fontWeight: FontWeight.w400))
                  :  Container(),
              rightW != null ? rightW! :  Container(),
              isRight??false
                  ?  Icon(CupertinoIcons.right_chevron,
                      color: Colours.c_FFC0C0C0)
                  :  Container(width: 10.0)
            ],
          ),
        ),
      ),
      margin: margin,
    );
  }
}
