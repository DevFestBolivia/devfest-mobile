import 'package:flutter/material.dart';

class SpacingValues {
  static const double xxs = 4;
  static const double xs = 8;
  static const double s = 12;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 20;
  static const double xxl = 24;
}

class VerticalSpacing {
  static const xxs = SizedBox(height: SpacingValues.xxs);
  static const xs = SizedBox(height: SpacingValues.xs);
  static const s = SizedBox(height: SpacingValues.s);
  static const m = SizedBox(height: SpacingValues.m);
  static const l = SizedBox(height: SpacingValues.l);
  static const xl = SizedBox(height: SpacingValues.xl);
  static const xxl = SizedBox(height: SpacingValues.xxl);
}

class HorizontalSpacing {
  static const xxs = SizedBox(width: SpacingValues.xxs);
  static const xs = SizedBox(width: SpacingValues.xs);
  static const s = SizedBox(width: SpacingValues.s);
  static const m = SizedBox(width: SpacingValues.m);
  static const l = SizedBox(width: SpacingValues.l);
  static const xl = SizedBox(width: SpacingValues.xl);
  static const xxl = SizedBox(width: SpacingValues.xxl);
}

class FontWeightValues {
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.bold;
  static FontWeight normal = FontWeight.normal;
  static FontWeight regular = FontWeight.w400;
}

class FontSizeValues {
  static double barItem = 12;
  static double label = 12;
  static double scheduleDetail = 14;
  static double input = 16;
  static double title = 24;
}

class BorderRadiusValues {
  static double input = 5;
}

class CardsSizeValues {
  static double width = 300;
  static double height = 123;
  static double day = 30;
  static double month = 14;
  static double hour = 18;
}

class ImageSizeValues {
  static double sectionIconWidth = 30;
  static double sectionIconHeight = 30;
}
