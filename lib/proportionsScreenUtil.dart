import 'package:flutter/cupertino.dart';

class ProportionsScreenUtil {
  static Set<double> getScreenSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return {width, height};
  }
}
