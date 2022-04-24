import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color_constants.dart';
import '../helpers/custom_route.dart';

final ThemeData theme = _buildCustomTheme();

ThemeData _buildCustomTheme() {
  return customThemeFoundation;
}

ThemeData customThemeFoundation = ThemeData(
  primaryColor: ColorConstants.primary,
  accentColor: ColorConstants.secondary,
  fontFamily: 'Raleway',
  scaffoldBackgroundColor: ColorConstants.background,
  backgroundColor: ColorConstants.background,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
        overline: GoogleFonts.poppins(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          color: ColorConstants.primary,
          shadows: [
            const Shadow(
              color: ColorConstants.primary,
              blurRadius: 2.0,
              offset: Offset(
                1.0,
                3.5,
              ),
            )
          ],
        ),
        headline6: GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          color: ColorConstants.primary,
        ),
      ),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorConstants.appBarBackground,
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: GoogleFonts.poppins(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
            color: ColorConstants.primary,
          ),
        ),
  ),
);
