import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.0.1.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///  theme: AppTheme.light,
///  darkTheme: AppTheme.dark,
///  :
/// );
class AppTheme {
  final lightColors = FlexSchemeColor.from(primary: Colors.teal);
  final darkColors = FlexSchemeColor.from(primary: Colors.black);
  late ThemeData light;
  late ThemeData dark;

  // Text config
  final TextStyle openSansRegular = GoogleFonts.openSans();
  final TextStyle interRegular = GoogleFonts.inter();
  final TextStyle merriWeather = GoogleFonts.merriweather();
  final TextStyle ubuntu = GoogleFonts.ubuntu();
  final TextStyle notoSerifGeorgianRegular = GoogleFonts.notoSerifGeorgian(
    fontWeight: FontWeight.w400,
  );
  final TextStyle notoSerifGeorgianMedium = GoogleFonts.notoSerifGeorgian(
    fontWeight: FontWeight.w500,
  );
  final TextStyle notoSerifGeorgianBold = GoogleFonts.notoSerifGeorgian(
    fontWeight: FontWeight.w700,
  );

  TextTheme _getTextTheme() {
    return TextTheme(
      displayLarge: merriWeather.copyWith(fontSize: 96.spMax),
      displayMedium: merriWeather.copyWith(fontSize: 60.spMax),
      displaySmall: merriWeather.copyWith(fontSize: 48.spMax),
      headlineLarge: merriWeather.copyWith(fontSize: 44.spMax),
      headlineMedium: merriWeather.copyWith(fontSize: 34.spMax),
      headlineSmall: merriWeather.copyWith(fontSize: 24.spMax),
      titleLarge: interRegular.copyWith(
        fontSize: 20.spMax,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: interRegular.copyWith(
        fontSize: 16.spMax,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: interRegular.copyWith(
        fontSize: 14.spMax,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: openSansRegular.copyWith(fontSize: 16.spMax),
      bodyMedium: openSansRegular.copyWith(fontSize: 14.spMax),
      bodySmall: openSansRegular.copyWith(fontSize: 12.spMax),
      labelLarge: ubuntu.copyWith(fontSize: 14.spMax),
      labelMedium: ubuntu.copyWith(fontSize: 10.spMax),
      labelSmall: ubuntu.copyWith(fontSize: 8.spMax),
    );
  }

  AppTheme() {
    light = FlexThemeData.light(
      scheme: FlexScheme.limeM3,
      colors: lightColors,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 1,
      subThemesData: FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        blendOnLevel: 8,
        useM2StyleDividerInM3: true,
        defaultRadius: 12.0,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.primary,
        unselectedToggleIsColored: true,
        sliderValueTinted: true,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorIsFilled: true,
        inputDecoratorBackgroundAlpha: 31,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorFocusedBorderWidth: 1.0,
        inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.tertiary,
        popupMenuRadius: 8.0,
        popupMenuElevation: 3.0,
        alignedDropdown: true,
        drawerIndicatorRadius: 12.0,
        drawerIndicatorSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarMutedUnselectedIcon: false,
        menuRadius: 8.0,
        menuElevation: 3.0,
        menuBarRadius: 0.0,
        menuBarElevation: 2.0,
        menuBarShadowColor: const Color(0x00000000),
        searchBarElevation: 1.0,
        searchViewElevation: 1.0,
        searchUseGlobalShape: true,
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationBarIndicatorSchemeColor: SchemeColor.primary,
        navigationBarIndicatorRadius: 12.0,
        navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
        navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationRailUseIndicator: true,
        navigationRailIndicatorSchemeColor: SchemeColor.primary,
        navigationRailIndicatorOpacity: 1.00,
        navigationRailIndicatorRadius: 12.0,
        navigationRailBackgroundSchemeColor: SchemeColor.surface,
        navigationRailLabelType: NavigationRailLabelType.all,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
        useError: true,
        keepPrimary: true,
      ),
      textTheme: _getTextTheme(),
      tones: FlexSchemeVariant.jolly.tones(Brightness.light),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      fontFamily: GoogleFonts.notoSerifGeorgian().fontFamily,
    );

    dark = FlexThemeData.dark(
      scheme: FlexScheme.limeM3,
      colors: darkColors,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 2,
      subThemesData: FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        blendOnLevel: 10,
        blendOnColors: true,
        useM2StyleDividerInM3: true,
        defaultRadius: 12.0,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.primary,
        unselectedToggleIsColored: true,
        sliderValueTinted: true,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorIsFilled: true,
        inputDecoratorBackgroundAlpha: 43,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorFocusedBorderWidth: 1.0,
        inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.tertiary,
        popupMenuRadius: 8.0,
        popupMenuElevation: 3.0,
        alignedDropdown: true,
        drawerIndicatorRadius: 12.0,
        drawerIndicatorSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarMutedUnselectedIcon: false,
        menuRadius: 8.0,
        menuElevation: 3.0,
        menuBarRadius: 0.0,
        menuBarElevation: 2.0,
        menuBarShadowColor: const Color(0x00000000),
        searchBarElevation: 1.0,
        searchViewElevation: 1.0,
        searchUseGlobalShape: true,
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationBarIndicatorSchemeColor: SchemeColor.primary,
        navigationBarIndicatorRadius: 12.0,
        navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
        navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationRailUseIndicator: true,
        navigationRailIndicatorSchemeColor: SchemeColor.primary,
        navigationRailIndicatorOpacity: 1.00,
        navigationRailIndicatorRadius: 12.0,
        navigationRailBackgroundSchemeColor: SchemeColor.surface,
        navigationRailLabelType: NavigationRailLabelType.all,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
        useError: true,
      ),
      textTheme: _getTextTheme(),
      tones: FlexSchemeVariant.jolly.tones(Brightness.dark),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      fontFamily: GoogleFonts.notoSerifGeorgian().fontFamily,
    );
  }
}
