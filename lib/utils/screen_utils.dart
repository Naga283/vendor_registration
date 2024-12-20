import 'package:flutter/material.dart';

class ScreenUtils {
  double width(BuildContext context) => MediaQuery.of(context).size.width;
  double height(BuildContext context) => MediaQuery.of(context).size.height;
}

final screenUtils = ScreenUtils();
