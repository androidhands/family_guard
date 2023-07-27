import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import '../../../utils/app_sizes.dart';
import '../theme_color/theme_color_dark.dart';

ThemeData get getThemeDataDark => ThemeData(
      cardColor: ThemeColorDark.containerCardColor,

      dialogBackgroundColor: ThemeColorDark.dialogBackgroundColor,
      primaryColor: ThemeColorDark.primaryColor,
      brightness: Brightness.dark,
      fontFamily: "Poppins-Regular",
      disabledColor: ThemeColorDark.disableColor,
      scaffoldBackgroundColor: ThemeColorDark.backgroundColor,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeColorDark.pinkColor,
      ),
      shadowColor: ThemeColorDark.shadowColor,
      iconTheme: const IconThemeData(color: ThemeColorDark.iconColor),
      dividerColor: ThemeColorDark.dividerColor,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ThemeColorDark.backgroundColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: ThemeColorDark.pinkWhiteColor,
          backgroundColor:
              ThemeColorDark.bottomNavigationBarColor.withOpacity(0.8),
          unselectedItemColor: ThemeColorDark.iconColor),
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeColorDark.appBarColor,
        // elevation: 0,
        titleTextStyle: TextStyle(
          color: ThemeColorDark.appBarTitleColor,
          fontFamily: AppFonts.fontFamilyEnglishSimiBold,
          fontWeight: AppFonts.semiBold,
          fontSize: AppSizes.h4,
        ),
      ),

      /// TextFormField
      inputDecorationTheme: InputDecorationTheme(
          fillColor: ThemeColorDark.containerCardColor,
          errorMaxLines: 3,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorDark.searchFormFieldColor,
              width: AppSizes.bs1_0,
            ),
            borderRadius: BorderRadius.circular(AppSizes.br4),
          ),
          outlineBorder: BorderSide(
            color: ThemeColorDark.searchFormFieldColor,
            width: AppSizes.bs1_0,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: ThemeColorDark.searchFormFieldColor,
                width: AppSizes.bs1_0,
              ),
              borderRadius: BorderRadius.circular(AppSizes.br12)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorDark.errorColor,
              width: AppSizes.bs1_0,
            ),
          ),
          errorStyle: TextStyle(
            color: ThemeColorDark.errorColor,
            fontSize: AppSizes.h6,
            fontWeight: AppFonts.regular,
            fontFamily: AppFonts.fontFamilyEnglishSimiBold,
          ),
          floatingLabelStyle: TextStyle(
              color: ThemeColorDark.pinkWhiteColor,
              fontWeight: AppFonts.medium,
              fontSize: AppSizes.h7),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorDark.searchFormFieldColor,
              width: AppSizes.bs1_0,
            ),
            borderRadius: BorderRadius.circular(AppSizes.br4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorDark.pinkWhiteColor,
              width: AppSizes.bs1_0,
            ),
            borderRadius: BorderRadius.circular(AppSizes.br4),
          ),
          labelStyle: TextStyle(
            color: ThemeColorDark.labelTextFieldColor,
            fontSize: AppSizes.h5,
            fontWeight: AppFonts.regular,
            fontFamily: AppFonts.fontFamilyEnglishNew,
          )),

      tabBarTheme: TabBarTheme(
        unselectedLabelColor: ThemeColorDark.unselectedLabelColor,
        labelStyle: TextStyle(
          color: ThemeColorDark.pinkColor,
          fontWeight: AppFonts.semiBold,
          fontSize: AppSizes.h5,
        ),
      ),

      /// ToggleButtons
      toggleButtonsTheme: ToggleButtonsThemeData(
        color: ThemeColorDark.primaryColor,
        selectedColor: ThemeColorDark.pinkWhiteColor,
        fillColor: ThemeColorDark.darkGray,
        borderRadius: BorderRadius.circular(AppSizes.br50),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: ThemeColorDark.primaryColor),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSizes.br8))),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(0)),
            backgroundColor:
                MaterialStateProperty.all<Color>(ThemeColorDark.pinkColor),
            overlayColor: MaterialStateProperty.all<Color>(
                ThemeColorDark.overlayElevatedButtonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.br8),
            ))),
      ),

      // textTheme: const TextTheme(
      //   bodyText1: TextStyle(
      //     color: Colors.white,
      //   ),
      // ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.br40),
        )),
        overlayColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
      )),
      hintColor: ThemeColorDark.lightGray,
      textTheme: getTextTheme(),
    
    );

getTextTheme() => TextTheme(

    /// 1. Text DisplaySmallBold pink
    displayLarge: TextStyle(
      color: ThemeColorDark.pinkColor,
      fontSize: AppSizes.h3,
      fontWeight: AppFonts.bold,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 2. Text DisplaySmall
    displaySmall: TextStyle(
      color: ThemeColorDark.secondaryColor,
      fontSize: AppSizes.h3,
      fontWeight: AppFonts.regular,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 3. Body Large gray
    bodyLarge: TextStyle(
      color: ThemeColorDark.primaryColor,
      fontSize: AppSizes.h3,
      fontWeight: AppFonts.bold,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 4. Link X Small GrayScale Solid
    titleSmall: TextStyle(
      color: ThemeColorDark.thirdColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.semiBold,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 5.  Link X Small Success green
    titleMedium: TextStyle(
      color: ThemeColorDark.successColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.semiBold,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 6. Error Text
    labelSmall: TextStyle(
      color: ThemeColorDark.errorColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.semiBold,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 7. Info Text
    displayMedium: TextStyle(
      color: ThemeColorDark.infoColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.medium,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 8. Warning Text
    headlineSmall: TextStyle(
      color: ThemeColorDark.warningColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.medium,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 9. Body Small white
    bodySmall: TextStyle(
      color: ThemeColorDark.whiteColor,
      fontSize: AppSizes.h4,
      fontWeight: AppFonts.medium,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ),

    /// 10. OffWhite Text
    bodyMedium: TextStyle(
      color: ThemeColorDark.offWhiteColor,
      fontSize: AppSizes.h6,
      fontWeight: AppFonts.regular,
      fontFamily: AppFonts.fontFamilyEnglishNew,
    ));
