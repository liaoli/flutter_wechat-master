import 'package:flutter/material.dart';

//PADDINGS - MARGINS
class Margin extends EdgeInsets {
  ///Do that:
  ///```dart
  ///EdgeInsets.zero
  ///```
  static const EdgeInsets zero = EdgeInsets.zero;

  ///Do that:
  ///```dart
  ///EdgeInsets.all(amount)
  ///```
  const Margin.all(double value) : super.all(value);

  ///Do that:
  ///```dart
  ///EdgeInsets.symmetric(vertical: amount)
  ///```
  const Margin.vertical(double amount) : super.symmetric(vertical: amount);

  ///Do that:
  ///```dart
  ///EdgeInsets.symmetric(horizontal: amount)
  ///```
  const Margin.horizontal(double amount) : super.symmetric(horizontal: amount);

  ///Do that:
  ///```dart
  ///EdgeInsets.only(top: amount)
  ///```
  const Margin.top(double amount) : super.only(top: amount);

  ///Do that:
  ///```dart
  ///EdgeInsets.only(right: amount)
  ///```
  const Margin.right(double amount) : super.only(right: amount);

  ///Do that:
  ///```dart
  /// EdgeInsets.only(bottom: amount)
  /// ```
  const Margin.bottom(double amount) : super.only(bottom: amount);

  ///Do that:
  ///```dart
  ///EdgeInsets.only(left: amount)
  ///```
  const Margin.left(double amount) : super.only(left: amount);

  ///Do that:
  ///```dart
  ///EdgeInsets.symmetric(horizontal: horizontal,
  ///vertical: vertical);
  ///```
  const Margin.symmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) : super.symmetric(horizontal: horizontal, vertical: vertical);

  ///Do that:
  ///```dart
  ///EdgeInsets.only(
  ///  top: top,
  ///  bottom: bottom,
  ///  left: left,
  ///  right: right,
  ///)
  ///```
  const Margin.only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) : super.only(left: left, top: top, right: right, bottom: bottom);
}

//BORDERS RADIUS
class EdgeRadius extends BorderRadius {
  ///Do that:
  ///```dart
  ///BorderRadius.zero
  ///```
  static const BorderRadius zero = BorderRadius.zero;

  ///Do that:
  ///```dart
  ///BorderRadius.all(Radius.circular(amount))
  ///```
  EdgeRadius.all(double radius) : super.all(Radius.circular(radius));

  ///Do that:
  ///```dart
  ///BorderRadius.vertical(
  ///  top: Radius.circular(top),
  ///  bottom: Radius.circular(bottom),
  ///)
  ///```
  ///
  ///
  EdgeRadius.vertical({double top = 0.0, double bottom = 0.0})
      : super.vertical(
            top: Radius.circular(top), bottom: Radius.circular(bottom));

  ///Do that:
  ///```dart
  ///BorderRadius.vertical(top: Radius.circular(top))
  ///```
  EdgeRadius.top(double radius) : super.vertical(top: Radius.circular(radius));

  ///Do that:
  ///```dart
  ///BorderRadius.vertical(bottom: Radius.circular(bottom))
  ///```
  EdgeRadius.bottom(double radius)
      : super.vertical(bottom: Radius.circular(radius));

  ///Do that:
  ///```dart
  ///BorderRadius.horizontal(
  ///  left: Radius.circular(left),
  ///  right: Radius.circular(right),
  ///)
  ///```
  EdgeRadius.horizontal({double left = 0.0, double right = 0.0})
      : super.horizontal(
          left: Radius.circular(left),
          right: Radius.circular(right),
        );

  ///Do that:
  ///```dart
  ///BorderRadius.horizontal(
  ///  left: Radius.circular(left),
  ///)
  ///```
  EdgeRadius.left(double left) : super.horizontal(left: Radius.circular(left));

  ///Do that:
  ///```dart
  ///BorderRadius.horizontal(right: Radius.circular(right))
  ///```
  EdgeRadius.right(double right)
      : super.horizontal(right: Radius.circular(right));

  ///Do that:
  ///```dart
  ///BorderRadius.only(
  ///  topLeft: Radius.circular(topLeft),
  ///  topRight: Radius.circular(topRight),
  ///  bottomLeft: Radius.circular(bottomLeft),
  ///  bottomRight: Radius.circular(bottomRight),
  ///)
  /// ```
  EdgeRadius.only({
    double topLeft = 0.0,
    double topRight = 0.0,
    double bottomLeft = 0.0,
    double bottomRight = 0.0,
  }) : super.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        );
}
