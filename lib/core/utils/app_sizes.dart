import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSizes {
  /// Full Screen Size
  static double heightFullScreen = Get.height;
  static double widthFullScreen = Get.width;

  /// Font Size
  static final double h1 = 48.0.sp;
  static final double h2 = 32.0.sp;
  static final double h3 = 24.0.sp;
  static final double h4 = 18.0.sp;
  static final double h5 = 16.0.sp;
  static final double h6 = 14.0.sp;
  static final double h7 = 12.0.sp;
  static final double h8 = 11.sp;

  /// Padding Size Height
  static final double pH1 = 6.0.h;
  static final double pH2 = 8.0.h;
  static final double pH3 = 12.0.h;
  static final double pH4 = 14.0.h;
  static final double pH5 = 16.0.h;
  static final double pH6 = 18.0.h;
  static final double pH7 = 24.0.h;
  static final double pH8 = 32.0.h;
  static final double pH9 = 75.0.h;
  static final double pH10 = 120.0.h;

  /// Padding Size Width
  static final double pW1 = 6.0.w;
  static final double pW2 = 8.0.w;
  static final double pW3 = 12.0.w;
  static final double pW4 = 14.0.w;
  static final double pW5 = 16.0.w;
  static final double pW6 = 18.0.w;
  static final double pW7 = 32.0.w;
  static final double pW8 = 40.0.w;
  static final double pW9 = 75.0.w;
  static final double pW10 = 120.0.h;

  /// Elevation Sizes
  static const double e1 = 2;
  static const double e2 = 4;
  static const double e3 = 6;

  /// Border Sizes
  static final double bs1_5 = 1.5.w;
  static final double bs1_0 = 1.0.w;
  static final double bs0_5 = 0.5.w;
  static final double bs0_2 = 0.2.w;

  /// Border Radius
  static final double br4 = 4.r;
  static final double br6 = 6.r;
  static final double br8 = 8.r;
  static final double br20 = 20.r;
  static final double br40 = 40.r;
  static final double br25 = 25.r;
  static final double br30 = 30.r;
  static final double br50 = 50.r;
  static final double brMax = 500.r;

  static final double br12 = 12.r;
  static final double br13 = 11.r;
  static final double br16 = 16.r;

  /// Images Sizes Height
  static final double imageHeightVerySmall = 30.h;
  static final double imageHeightSmall = 50.h;
  static final double imageHeightMedium = 100.h;
  static final double imageHeightLarge = 200.h;
  static final double notificationIconSize = 50.h;

  /// Images Sizes Width

  static final double imageWidthSmall = 50.w;
  static final double profileImageWidth = 80.w;
  static final double imageWidthMedium = 80.w;
  static final double imageWidthLarge = 200.w;

  /// Loading Indicator Size
  static final double loadingIndicatorLargeWidth = 100.w;
  static final double loadingIndicatorLargeSize = 90.h;
  static final double loadingIndicatorMediumSize = 15.h;
  static final double loadingIndicatorFOrSocialMediaSize = 35.h;
  static final double loadingIndicatorSmall = 35.h;

  static final double loadingIndicatorThick = 1.h;

  static final double locationIndicatorHight = 30.h;
  static final double locationIndicatorWidth = 30.w;

  static final double profileImageHight = 80.h;

  /// icons Sizes
  static final double logoSize = 47.w;
  static final double iconSize = 21.5.h;
  static final double backIconSize = 27.h;
  static final double suffixIconsSizes = 14.h;
  static final double checkIconsSizes = 45.h;
  static final double backButtonHight = 20.h;
  static final double tryAgainButtonSize = 120.w;
  static final double backButtonWidth = 20.w;
  static final double actionBarButtonsHight = 40.h;

  /// Elevated Button Sizes
  static final double largeButtonHeight = 45.h;
  static final double socialMediaButtonSize = 56.h;
  static final double dropDownButtonSize = 55.h;
  static final double countryPickerHeight = 52.h;

  /// SizedBox Height
  static double sizedBoxH1 = 32.h;
  static double sizedBoxH2 = 25.h;
  static double sizedBoxH3 = 20.h;
  static double sizedBoxH4 = 10.h;
  static double sizedBoxH5 = 5.h;

  /// SizedBox Width
  static double sizedBoxW1 = 180.w;
  static double sizedBoxW2 = 55.w;
  static double sizedBoxW3 = 10.w;

  /// Toggle Button Width
  static double toggleButtonWidth = 396.w;
  static double toggleButtonHeight = 44.h;
  static double switchToggleButtonWidth = 170.w;

  /// Appointment typ Sizes
  static double appointmentTypWidth = 81.w;
  static double appointmentTypHeight = 25.h;

  ///Drop Down Sizes
  static double dropDownWidth = Get.width - 100.w;
  static double dropDownHeight = 250.h;

  ///Container Sizes
  static double coverIconsContainerHeight = 26.h;
  static double coverIconsContainerWidth = 117.h;
  static final double containerIconSize = 40.h;
  static final double containerBorderIconSize = 60.h;

  ///Tablet
  static double tabBarHeightForTablet = 50.h;

  ///Appbar
  static double appBarHeight = 64.h;

  /// Service Component
  static double serviceComponentHeight = 135.h;
  static double serviceComponentWidth =
      (AppSizes.widthFullScreen / 2) - AppSizes.pW5 * 2;

  /// Appointment Time Container
  static double appointmentTimeContainerHeight = 120.h;

  /// Pie Chart
  static double heightCustomPieChart = 118.w;
  static double ringStrokeWidth = 12.w;

  ///payment History
  static double paymentHistoryBottomSheetModalHeight = 350.h;
  static double confirmPaymentBottomSheetModalHeight = 300.h;
  static double editTotalBottomSheetModalHeight = 275.h;
  static double workBottomSheetModalHeight = 300.h;
  static final double lineBottomSheetModalHeight = 3.0.h;
  static final double lineBottomSheetModalWidth = 80.0.w;
  static final double imageIconPaymentHistorySize = 48.h;
  static final double closeIconChangeDateSize = 35.h;

  ///DropDown
  static final double countryDropDownButtonWidth = 115.w;

  ///calender
  static final double daysOfWeekHeight = 35.h;
  static final double rowHeightHeight = 50.h;

  /// Check Box
  static final double checkBoxSize = 18.w;
  static final double checkBoxPaddingHight = 4.h;
  static final double checkBoxPaddingWidth = 4.w;

  ///height
  static final double heightPinCode = 50.h;
  static final double countryFlagHeight = 16.h;
  static final double imageProfileHeightInHomeScreen = 40.h;
  static final double imageCompanyHeightInHomeScreen = 40.h;
  static final double countryFlagHight = 16.h;
  static final double customCardH1 = 118.h;
  static final double customCardH2 = 72.h;
  static final double logoImageHeight = 75.h;
  static final double sizedBoxH = 36.h;
  static final double bottomNavBarHeight = 70.h;
  static final double commonButtonsHight = 60.h;
  static final double enableLocationIconHight = 200.h;
  static final double registrationPhotoHeight = 237.h;
  static final double imageProfileLargeSize = 120.h;
  static final double imageProfileSmallSize = 40.h;
  static final double businessImageProfileSmallSize = 50.h;
  static final double branchImageCoverHeight = 230.h;
  static final double branchGenderWidgetHeight = 110.w;
  static final double branchGenderWidgetWidth = 200.h;
  static final double branchLocationWidgetHeight = 200.h;
  static final double tabBarHeight = 50.h;
  static final double dataCompletionBannerHeight = 112.h;
  static final double branchCardHeight = 170.h;
  static final double contentItemCardHeight = 105.h;
  static final double targetAudienceContainerSize = 50.h;
  static final double dotSize = 5.w;
  static final double requestCardHeight = 180.h;

  ///width
  static final double widthPinCode = 50.w;
  static final double countryFlagWidth = 24.w;
  static final double logoImageWidth = 200.w;
  static final double organizationImageWidth = 65.w;
  static final double organizationImageHight = 65.h;
  static final double dividerWidth = 66.w;
  static final double registrationPhotoWidth = 364.w;
  static final double mediumBorderGradientWidth = 2.w;
  static final double smallBorderGradientWidth = 0.5.w;
  static final double branchCardWidth = 375.w;
  static final double contentItemCardWidth = 128.w;
  static final double locationShimmerWidth = 150.w;

  /// marigin
  static final double logoImageTop = 71.w;

  ///Divider thickness
  static final double dividerThickness = 2.h;
  static final double dividerThickness2 = 3.h;

  ///Bottom Modal Sheet Size
  static final double modalBottomSheetLowSize = 220.h;

  ///Organization Card
  static final double organizationCardHight = 200.0.h;
  static final double organizationCardWidth = 100.0.w;
  static final double organizationCardWidth2 = 150.0.w;
  static final double organizationCardRadius = 12.0.r;

  ///Notification Card
  static final double notificationCardHight = 64.0.h;
  static final double notificationCardRadius = 6.0.r;

  ///Snackbar Sized
  static final double singleLineSnackbarHight = 50.0.h;
  static final double twoLineSnackbarHight = 70.0.h;
  static final double twoLineSnackbarLongerActionHight = 112.0.h;

  ///position
  static final double cameraEditPosition = 5.h;

  ///icon size
  static final double mediumIconSize = 35.h;
  static final double smallIconSize = 30.h;

  //Date PickerDialog hieght
  static final double datePickerHight = 40.h;
  static final double datePickerMariginH = 4.h;
  static final double datePickerMariginW = 4.w;

  //single visit container hieght
  static final double singleVisitContainerH = 100.h;

  //Dm KPIs card sizes
  static final double kpisCardW = 50.w;
  static final double kpisCardH = 50.h;

  static final double amAccountListHight = 120.h;

  static final double chipChoiceHigh = 60.h;

  static final double mapAddressHigh = 300.h;
  static final double mapAddressHight2 = 200.h;

  static final double bottomBarIconHigh = 50.h;
  static final double bottomBarIconWidth = 50.w;
}
