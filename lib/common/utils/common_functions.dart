import 'package:flutter/material.dart';

class CommonFunctions {
  // Define your threshold for a 'small' device width
  static const double smallDeviceWidth = 360.0;
  static double deviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  bool isSmallDeviceWidth(){
    if (smallDeviceWidth < smallDeviceWidth) {
      // Code for small width devices
      return true;
    } else {
      // Code for larger devices
      return false;
    }
  }

}
