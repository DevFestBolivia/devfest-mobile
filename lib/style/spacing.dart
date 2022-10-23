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
