import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  AppTheme._();

  static final ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.espresso,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 8,
    appBarElevation: 0.5,
    appBarOpacity: 0.5,
    visualDensity: VisualDensity.standard,
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static final ThemeData dark = FlexColorScheme.dark(
    scheme: FlexScheme.espresso,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 18,
    appBarElevation: 1,
    appBarOpacity: 0.5,
    visualDensity: VisualDensity.standard,
    fontFamily: GoogleFonts.notoSans().fontFamily,
  ).toTheme;
}
