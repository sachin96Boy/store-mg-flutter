import 'package:flutter/material.dart';

class CustomTheme extends ThemeExtension<CustomTheme> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final Color accentColor;
  final Color errorColor;
  final Color successColor;
  final Color warningColor;
  final Color infoColor;
  final Color inversePrimaryColor;
  final Color inverseSecondaryColor;
  final Color inversePrimaryTextColor;
  final Color inverseSecondaryTextColor;
  final Color inverseBackgroundColor;
  final Color inverseAccentColor;
  final Color inverseErrorColor;
  final Color inverseSuccessColor;
  final Color inverseWarningColor;
  final Color inverseInfoColor;

  CustomTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.backgroundColor,
    required this.accentColor,
    required this.errorColor,
    required this.successColor,
    required this.warningColor,
    required this.infoColor,
    required this.inversePrimaryColor,
    required this.inverseSecondaryColor,
    required this.inversePrimaryTextColor,
    required this.inverseSecondaryTextColor,
    required this.inverseBackgroundColor,
    required this.inverseAccentColor,
    required this.inverseErrorColor,
    required this.inverseSuccessColor,
    required this.inverseWarningColor,
    required this.inverseInfoColor,
  });

  ThemeData toTheme(ThemeData base) {
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        primaryContainer: primaryColor,
        secondaryContainer: secondaryColor,
        onPrimary: primaryTextColor,
        onSecondary: secondaryTextColor,
        surface: backgroundColor,
        onSurfaceVariant: primaryTextColor,
        onSurface: primaryTextColor,
        error: errorColor,
        onError: primaryTextColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: primaryColor,
        foregroundColor: primaryTextColor,
      ),
      textTheme: base.textTheme.copyWith(
        headlineLarge: base.textTheme.headlineLarge!.copyWith(
          color: primaryTextColor,
        ),
        headlineMedium: base.textTheme.headlineMedium!.copyWith(
          color: primaryTextColor,
        ),
        headlineSmall: base.textTheme.headlineSmall!.copyWith(
          color: primaryTextColor,
        ),
        titleLarge: base.textTheme.titleLarge!.copyWith(
          color: primaryTextColor,
        ),
        titleMedium: base.textTheme.titleMedium!.copyWith(
          color: primaryTextColor,
        ),
        titleSmall: base.textTheme.titleSmall!.copyWith(
          color: primaryTextColor,
        ),
        bodyLarge: base.textTheme.bodyLarge!.copyWith(
          color: primaryTextColor,
        ),
        bodyMedium: base.textTheme.bodyMedium!.copyWith(
          color: primaryTextColor,
        ),
        bodySmall: base.textTheme.bodySmall!.copyWith(
          color: primaryTextColor,
        ),
        displayLarge: base.textTheme.displayLarge!.copyWith(
          color: primaryTextColor,
        ),
        displayMedium: base.textTheme.displayMedium!.copyWith(
          color: primaryTextColor,
        ),
        displaySmall: base.textTheme.displaySmall!.copyWith(
          color: primaryTextColor,
        ),
        labelLarge: base.textTheme.labelLarge!.copyWith(
          color: primaryTextColor,
        ),
        labelMedium: base.textTheme.labelMedium!.copyWith(
          color: primaryTextColor,
        ),
        labelSmall: base.textTheme.labelSmall!.copyWith(
          color: primaryTextColor,
        ),
      ),
    );
  }

  static CustomTheme fromTheme(ThemeData theme) {
    return CustomTheme(
      primaryColor: theme.colorScheme.primary,
      secondaryColor: theme.colorScheme.secondary,
      primaryTextColor: theme.colorScheme.onPrimary,
      secondaryTextColor: theme.colorScheme.onSecondary,
      backgroundColor: theme.colorScheme.surface,
      accentColor: theme.colorScheme.secondary,
      errorColor: theme.colorScheme.error,
      successColor: theme.colorScheme.primary,
      warningColor: theme.colorScheme.secondary,
      infoColor: theme.colorScheme.onSurface,
      inversePrimaryColor: theme.colorScheme.onPrimary,
      inverseSecondaryColor: theme.colorScheme.onSecondary,
      inversePrimaryTextColor: theme.colorScheme.primary,
      inverseSecondaryTextColor: theme.colorScheme.secondary,
      inverseBackgroundColor: theme.colorScheme.surface,
      inverseAccentColor: theme.colorScheme.primary,
      inverseErrorColor: theme.colorScheme.primary,
      inverseSuccessColor: theme.colorScheme.primary,
      inverseWarningColor: theme.colorScheme.primary,
      inverseInfoColor: theme.colorScheme.primary,
    );
  }

  ColorScheme get colorScheme => ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        primaryContainer: primaryColor,
        secondaryContainer: secondaryColor,
        onPrimary: primaryColor,
        onSecondary: secondaryColor,
        surface: backgroundColor,
        onSurfaceVariant: primaryTextColor,
        onSurface: primaryTextColor,
        error: errorColor,
        onError: primaryTextColor,
      );

  TextTheme get textTheme => TextTheme(
        headlineLarge: TextStyle(color: primaryTextColor),
        headlineMedium: TextStyle(color: primaryTextColor),
        headlineSmall: TextStyle(color: primaryTextColor),
        titleLarge: TextStyle(color: primaryTextColor),
        titleMedium: TextStyle(color: primaryTextColor),
        titleSmall: TextStyle(color: primaryTextColor),
        bodyLarge: TextStyle(color: primaryTextColor),
        bodyMedium: TextStyle(color: primaryTextColor),
        bodySmall: TextStyle(color: primaryTextColor),
        displayLarge: TextStyle(color: primaryTextColor),
        displayMedium: TextStyle(color: primaryTextColor),
        displaySmall: TextStyle(color: primaryTextColor),
        labelLarge: TextStyle(color: primaryTextColor),
        labelMedium: TextStyle(color: primaryTextColor),
        labelSmall: TextStyle(color: primaryTextColor),
      );

  AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: primaryTextColor,
      );

  FloatingActionButton get floatingActionButton => FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: primaryTextColor,
        onPressed: () {},
      );

  @override
  ThemeExtension<CustomTheme> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? backgroundColor,
    Color? accentColor,
    Color? errorColor,
    Color? successColor,
    Color? warningColor,
    Color? infoColor,
    Color? inversePrimaryColor,
    Color? inverseSecondaryColor,
    Color? inversePrimaryTextColor,
    Color? inverseSecondaryTextColor,
    Color? inverseBackgroundColor,
    Color? inverseAccentColor,
    Color? inverseErrorColor,
    Color? inverseSuccessColor,
    Color? inverseWarningColor,
    Color? inverseInfoColor,
  }) {
    return CustomTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      accentColor: accentColor ?? this.accentColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      inversePrimaryColor: inversePrimaryColor ?? this.inversePrimaryColor,
      inverseSecondaryColor:
          inverseSecondaryColor ?? this.inverseSecondaryColor,
      inversePrimaryTextColor:
          inversePrimaryTextColor ?? this.inversePrimaryTextColor,
      inverseSecondaryTextColor:
          inverseSecondaryTextColor ?? this.inverseSecondaryTextColor,
      inverseBackgroundColor:
          inverseBackgroundColor ?? this.inverseBackgroundColor,
      inverseAccentColor: inverseAccentColor ?? this.inverseAccentColor,
      inverseErrorColor: inverseErrorColor ?? this.inverseErrorColor,
      inverseSuccessColor: inverseSuccessColor ?? this.inverseSuccessColor,
      inverseWarningColor: inverseWarningColor ?? this.inverseWarningColor,
      inverseInfoColor: inverseInfoColor ?? this.inverseInfoColor,
    );
  }

  @override
  ThemeExtension<CustomTheme> lerp(
      covariant ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) return this;

    return CustomTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      primaryTextColor:
          Color.lerp(primaryTextColor, other.primaryTextColor, t)!,
      secondaryTextColor:
          Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      inversePrimaryColor:
          Color.lerp(inversePrimaryColor, other.inversePrimaryColor, t)!,
      inverseSecondaryColor:
          Color.lerp(inverseSecondaryColor, other.inverseSecondaryColor, t)!,
      inversePrimaryTextColor: Color.lerp(
          inversePrimaryTextColor, other.inversePrimaryTextColor, t)!,
      inverseSecondaryTextColor: Color.lerp(
          inverseSecondaryTextColor, other.inverseSecondaryTextColor, t)!,
      inverseBackgroundColor:
          Color.lerp(inverseBackgroundColor, other.inverseBackgroundColor, t)!,
      inverseAccentColor:
          Color.lerp(inverseAccentColor, other.inverseAccentColor, t)!,
      inverseErrorColor:
          Color.lerp(inverseErrorColor, other.inverseErrorColor, t)!,
      inverseSuccessColor:
          Color.lerp(inverseSuccessColor, other.inverseSuccessColor, t)!,
      inverseWarningColor:
          Color.lerp(inverseWarningColor, other.inverseWarningColor, t)!,
      inverseInfoColor:
          Color.lerp(inverseInfoColor, other.inverseInfoColor, t)!,
    );
  }
}
