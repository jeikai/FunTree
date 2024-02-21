import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray600,
      );
  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green50,
      );
  static BoxDecoration get fillGreen200 => BoxDecoration(
        color: appTheme.green200,
      );
  static BoxDecoration get fillGreen60001 => BoxDecoration(
        color: appTheme.green60001,
      );
  static BoxDecoration get fillGreenBc => BoxDecoration(
        color: appTheme.green300Bc,
      );
  static BoxDecoration get fillLightGreen => BoxDecoration(
        color: appTheme.lightGreen100,
      );
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError.withOpacity(0.83),
      );
  static BoxDecoration get fillOnError1 => BoxDecoration(
        color: theme.colorScheme.onError,
      );
}

class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderTL20 => BorderRadius.vertical(
        top: Radius.circular(20.h),
      );
  static BorderRadius get customBorderTL30 => BorderRadius.vertical(
        top: Radius.circular(30.h),
      );
  static BorderRadius get customBorderTL301 => BorderRadius.only(
        topLeft: Radius.circular(30.h),
        topRight: Radius.circular(30.h),
        bottomLeft: Radius.circular(20.h),
        bottomRight: Radius.circular(20.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15.h,
      );
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
