import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData get getThemeDataLight => ThemeData(
    cardColor: ThemeColorLight.containerCardColor,
    dialogBackgroundColor: ThemeColorLight.dialogBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: ThemeColorLight.pinkColor,
        backgroundColor: ThemeColorLight.bottomNavigationBarColor,
        unselectedItemColor: ThemeColorLight.pinkWhiteColor),
    highlightColor: ThemeColorLight.highlightColorBorderForPinTextField,
    primaryColor: ThemeColorLight.primaryColor,
    disabledColor: ThemeColorLight.disableColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ThemeColorLight.backgroundColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ThemeColorLight.pinkColor,
    ),
    iconTheme: IconThemeData(color: ThemeColorLight.offWhiteColor),
    shadowColor: ThemeColorLight.shadowColor,
    dividerColor: ThemeColorLight.gray,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ThemeColorLight.backgroundColor,
    ),

    /// ToggleButtons
    toggleButtonsTheme: ToggleButtonsThemeData(
      color: ThemeColorLight.secondaryColor,
      selectedColor: ThemeColorLight.lightGray,
      fillColor: ThemeColorLight.darkGray,
      borderColor: ThemeColorLight.secondaryColor,
      borderRadius: BorderRadius.circular(AppSizes.br50),
    ),

    /// TextFormField

    inputDecorationTheme: InputDecorationTheme(
        fillColor: ThemeColorLight.fillColorTextFormField,
        errorMaxLines: 3,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColorLight.searchFormFieldColor,
            width: AppSizes.bs1_0,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br4),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColorLight.searchFormFieldColor,
            width: AppSizes.bs1_0,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColorLight.errorColor,
            width: AppSizes.bs1_0,
          ),
        ),
        hintStyle: TextStyle(
            color: ThemeColorLight.hintTextFieldColor,
            fontWeight: AppFonts.regular,
            fontSize: AppSizes.h6),
        outlineBorder: BorderSide(
          color: ThemeColorLight.searchFormFieldColor,
          width: AppSizes.bs1_0,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColorLight.searchFormFieldColor,
            width: AppSizes.bs1_0,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br4),
        ),
        floatingLabelStyle: TextStyle(
            color: ThemeColorLight.pinkColor,
            fontWeight: AppFonts.medium,
            fontSize: AppSizes.h7),
        errorStyle: TextStyle(
          color: ThemeColorLight.errorColor,
          fontSize: AppSizes.h7,
          fontWeight: AppFonts.regular,
          fontFamily: AppFonts.fontFamilyEnglishSimiBold,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColorLight.pinkColor,
            width: AppSizes.bs1_0,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br4),
        ),
        labelStyle: TextStyle(
          color: ThemeColorLight.pinkColor,
          fontSize: AppSizes.h5,
          fontWeight: AppFonts.regular,
          fontFamily: AppFonts.fontFamilyEnglish,
        )),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: ThemeColorLight.unselectedLabelColor,
      labelStyle: TextStyle(
        color: ThemeColorLight.pinkColor,
        fontWeight: AppFonts.semiBold,
        fontSize: AppSizes.h5,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeColorLight.containerCardColor,
      // elevation: 0,
      titleTextStyle: TextStyle(
        color: ThemeColorLight.appBarTitleColor,
        fontFamily: AppFonts.fontFamilyEnglishMedium,
        fontWeight: AppFonts.medium,
        fontSize: 18.sp,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.br8),
      ),
      disabledColor: ThemeColorLight.disableButtonColor,
      highlightColor: ThemeColorLight.overlayElevatedButtonColor,
      splashColor: ThemeColorLight.overlayElevatedButtonColor,
    ),
    fontFamily: "Poppins-Regular",
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(0)),
          shadowColor:
              MaterialStateProperty.all<Color>(ThemeColorLight.pinkWhiteColor),
          surfaceTintColor:
              MaterialStateProperty.all<Color>(ThemeColorLight.pinkColor),
          foregroundColor: MaterialStateProperty.all<Color>(
              ThemeColorLight.disableButtonColor),
          overlayColor: MaterialStateProperty.all<Color>(
              ThemeColorLight.overlayElevatedButtonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.br8),
          ))),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      side: const BorderSide(color: ThemeColorLight.pinkColor),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.br8))),
    )),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.br40),
            )),
            overlayColor: MaterialStateProperty.all<Color>(
                ThemeColorLight.overLayColor))),
    hintColor: ThemeColorLight.lightGray,
    textTheme: getTextTheme(),
    radioTheme: RadioThemeData(
        fillColor:
            MaterialStateProperty.all<Color>(ThemeColorLight.pinkColor)));

getTextTheme() => TextTheme(

    /// 1. Text DisplaySmallBold pink
    displayLarge: TextStyle(
      color: ThemeColorLight.pinkColor,
      fontSize: AppSizes.h3,
      fontWeight: AppFonts.bold,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 2. Text DisplaySmall
    displaySmall: TextStyle(
      color: ThemeColorLight.primaryColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.regular,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 3. Body Large gray
    bodyLarge: TextStyle(
      color: ThemeColorLight.primaryColor,
      fontSize: AppSizes.h3,
      fontWeight: AppFonts.bold,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 4. Link X Small GrayScale Solid
    titleSmall: TextStyle(
      color: ThemeColorLight.thirdColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.semiBold,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 5.  Success green
    titleMedium: TextStyle(
      color: ThemeColorLight.pinkColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.semiBold,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 6. Error Text
    labelSmall: TextStyle(
      color: ThemeColorLight.errorColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.semiBold,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 7. Info Text
    displayMedium: TextStyle(
      color: ThemeColorLight.infoColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.medium,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 8. Warning Text
    headlineSmall: TextStyle(
      color: ThemeColorLight.warningColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.medium,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 9. Body Small white
    bodySmall: TextStyle(
      color: ThemeColorLight.whiteColor,
      fontSize: AppSizes.h4,
      fontWeight: AppFonts.medium,
      fontFamily: AppFonts.fontFamilyEnglish,
    ),

    /// 10. OffWhite Text
    bodyMedium: TextStyle(
      color: ThemeColorLight.offWhiteColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.regular,
      fontFamily: AppFonts.fontFamilyEnglish,
    ));
