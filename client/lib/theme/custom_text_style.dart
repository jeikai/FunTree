import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomTextStyles {
  // Body text style
  static get bodyLargeGreen600 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.green600,
      );
  static get bodyMedium14 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.fSize,
      );
  static get bodyMediumBluegray700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray700,
      );
  static get bodyMediumGray600 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray600,
        fontSize: 13.fSize,
      );
  static get bodyMediumGreen600 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.green600,
      );
  static get bodyMediumOnError => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onError.withOpacity(0.83),
        fontSize: 13.fSize,
      );
  static get bodyMediumOnError14 => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 14.fSize,
      );
  static get bodyMediumOnError_1 => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onError,
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
      );
  static get bodyMediumPrimaryContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 13.fSize,
      );
  static get bodyMediumff445d48 => theme.textTheme.bodyMedium!.copyWith(
        color: Color(0XFF445D48),
        fontSize: 14.fSize,
      );
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmallGray300 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray300,
      );
  static get bodySmallOnError => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 12.fSize,
      );
  static get bodySmallOnError_1 => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onError,
      );
  static get bodySmallOnPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 12.fSize,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
        fontSize: 12.fSize,
      );
  static get bodySmallff445d48 => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFF445D48),
        fontSize: 12.fSize,
      );
  static get bodySmallffff9b57 => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFFFF9B57),
        fontSize: 12.fSize,
      );
  static get bodySmallffffffff => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFFFFFFFF),
        fontSize: 12.fSize,
      );
  // Display text style
  static get displayMediumLightgreen100 =>
      theme.textTheme.displayMedium!.copyWith(
        color: appTheme.lightGreen100,
      );
  static get displayMediumOnPrimary => theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  // Headline text style
  static get headlineLargeBluegray700 =>
      theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.blueGray700,
      );
  static get headlineLargeGreen60001 => theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.green60001,
      );
  static get headlineSmallLightgreen100 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.lightGreen100,
      );
  // Itim text style
  static get itimPrimary => TextStyle(
        color: theme.colorScheme.primary.withOpacity(1),
        fontSize: 5.fSize,
        fontWeight: FontWeight.w400,
      ).itim;
  // Title text style
  static get titleLargeLightgreen100 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.lightGreen100,
      );
  static get titleLargeff445d48 => theme.textTheme.titleLarge!.copyWith(
        color: Color(0XFF445D48),
      );
  static get titleLargeffff9b57 => theme.textTheme.titleLarge!.copyWith(
        color: Color(0XFFFF9B57),
      );
}

extension on TextStyle {
  TextStyle get itim {
    return copyWith(
      fontFamily: 'Itim',
    );
  }
}
