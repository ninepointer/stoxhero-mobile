import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

import '../core.dart';

extension CustomStyles on TextTheme {
  TextStyle get tsFontFamily => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: AppTheme.fontFamily,
      );
  TextStyle get tsRegular10 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      );
  TextStyle get tsRegular11 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 11,
      );
  TextStyle get tsRegular12 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );

  TextStyle get tsRegular14 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
  TextStyle get tsRegular16 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
  TextStyle get tsRegular18 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  TextStyle get tsRegular20 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );
  TextStyle get tsRegular24 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 24,
      );
  TextStyle get tsMedium10 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      );
  TextStyle get tsMedium12 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );
  TextStyle get tsMedium14 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  TextStyle get tsMedium16 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  TextStyle get tsMedium18 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get tsMedium20 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get tsMedium24 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );

  TextStyle get tsSemiBold10 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
  TextStyle get tsSemiBold12 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
  TextStyle get tsSemiBold14 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  TextStyle get tsSemiBold16 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get tsSemiBold18 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  TextStyle get tsSemiBold20 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get tsSemiBold24 => TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  TextStyle get tsPrimaryRegular10 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      );
  TextStyle get tsPrimaryRegular12 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );
  TextStyle get tsPrimaryRegular14 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
  TextStyle get tsPrimaryRegular16 => TextStyle(
        color: AppColors.lightGreen,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
  TextStyle get tsPrimaryRegular18 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  TextStyle get tsPrimaryRegular20 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );
  TextStyle get tsPrimaryRegular24 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 24,
      );
  TextStyle get tsPrimaryMedium10 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      );
  TextStyle get tsPrimaryMedium12 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );
  TextStyle get tsPrimaryMedium14 => TextStyle(
        color: Get.isDarkMode ? AppColors.lightGreen : AppColors.darkGreen,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  TextStyle get tsPrimaryMedium16 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  TextStyle get tsPrimaryMedium18 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get tsPrimaryMedium20 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get tsPrimaryMedium24 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );

  TextStyle get tsPrimarySemiBold10 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
  TextStyle get tsPrimarySemiBold12 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
  TextStyle get tsPrimarySemiBold14 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  TextStyle get tsPrimarySemiBold16 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get tsPrimarySemiBold18 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  TextStyle get tsPrimarySemiBold20 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get tsPrimarySemiBold24 => TextStyle(
        color: AppColors.primary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );

  TextStyle get tsSecondaryRegular10 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      );
  TextStyle get tsSecondaryRegular12 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );
  TextStyle get tsSecondaryRegular14 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
  TextStyle get tsSecondaryRegular16 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
  TextStyle get tsSecondaryRegular18 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  TextStyle get tsSecondaryRegular20 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );
  TextStyle get tsSecondaryRegular24 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 24,
      );
  TextStyle get tsSecondaryMedium10 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      );
  TextStyle get tsSecondaryMedium12 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );
  TextStyle get tsSecondaryMedium14 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  TextStyle get tsSecondaryMedium16 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  TextStyle get tsSecondaryMedium18 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get tsSecondaryMedium20 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get tsSecondaryMedium24 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );

  TextStyle get tsSecondarySemiBold10 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
  TextStyle get tsSecondarySemiBold12 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
  TextStyle get tsSecondarySemiBold14 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  TextStyle get tsSecondarySemiBold16 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get tsSecondarySemiBold18 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  TextStyle get tsSecondarySemiBold20 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get tsSecondarySemiBold24 => TextStyle(
        color: AppColors.secondary,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );

  TextStyle get tsWhiteRegular10 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      );
  TextStyle get tsWhiteRegular12 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );
  TextStyle get tsWhiteRegular14 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
  TextStyle get tsWhiteRegular16 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
  TextStyle get tsWhiteRegular18 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  TextStyle get tsWhiteRegular20 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );
  TextStyle get tsWhiteRegular24 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 24,
      );

  TextStyle get tsWhiteMedium10 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      );
  TextStyle get tsWhiteMedium12 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );
  TextStyle get tsWhiteMedium14 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  TextStyle get tsWhiteMedium16 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  TextStyle get tsWhiteMedium18 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get tsWhiteMedium20 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get tsWhiteMedium24 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );

  TextStyle get tsWhiteSemiBold10 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
  TextStyle get tsWhiteSemiBold12 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
  TextStyle get tsWhiteSemiBold14 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  TextStyle get tsWhiteSemiBold16 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get tsWhiteSemiBold18 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  TextStyle get tsWhiteSemiBold20 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get tsWhiteSemiBold22 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  TextStyle get tsWhiteSemiBold24 => TextStyle(
        color: AppColors.white,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );

  TextStyle get tsBlackRegular10 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      );
  TextStyle get tsBlackRegular12 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );
  TextStyle get tsBlackRegular14 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
  TextStyle get tsBlackRegular16 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
  TextStyle get tsBlackRegular18 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  TextStyle get tsBlackRegular20 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );
  TextStyle get tsBlackRegular24 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 24,
      );

  TextStyle get tsBlackMedium10 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      );
  TextStyle get tsBlackMedium12 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );
  TextStyle get tsBlackMedium14 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  TextStyle get tsBlackMedium16 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  TextStyle get tsBlackMedium18 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get tsBlackMedium20 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get tsBlackMedium24 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );

  TextStyle get tsBlackSemiBold10 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
  TextStyle get tsBlackSemiBold12 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
  TextStyle get tsBlackSemiBold14 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  TextStyle get tsBlackSemiBold16 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get tsBlackSemiBold18 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  TextStyle get tsBlackSemiBold20 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get tsBlackSemiBold24 => TextStyle(
        color: AppColors.black,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );

  TextStyle get tsGreyRegular10 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      );
  TextStyle get tsGreyRegular12 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );
  TextStyle get tsGreyRegular14 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
  TextStyle get tsGreyRegular16 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
  TextStyle get tsGreyRegular18 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  TextStyle get tsGreyRegular20 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );
  TextStyle get tsGreyRegular24 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 24,
      );
  TextStyle get tsGreyMedium10 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      );
  TextStyle get tsGreyMedium12 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );
  TextStyle get tsGreyMedium14 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  TextStyle get tsGreyMedium16 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  TextStyle get tsGreyMedium18 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get tsGreyMedium20 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get tsGreyMedium24 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );

  TextStyle get tsGreySemiBold10 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
  TextStyle get tsGreySemiBold12 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
  TextStyle get tsGreySemiBold14 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  TextStyle get tsGreySemiBold16 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get tsGreySemiBold18 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  TextStyle get tsGreySemiBold20 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get tsGreySemiBold24 => TextStyle(
        color: AppColors.grey,
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
      TextStyle get tsLightGrey16 => TextStyle(
        color: AppColors.grey[200],
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
}

class AppStyles {
  static TextStyle tsPrimaryRegular10 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static TextStyle tsPrimaryRegular12 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle tsPrimaryRegular14 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle tsPrimaryRegular16 = TextStyle(
    color: AppColors.lightGreen,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle tsPrimaryRegular18 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static TextStyle tsPrimaryRegular20 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
  static TextStyle tsPrimaryRegular24 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
  static TextStyle tsPrimaryMedium10 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static TextStyle tsPrimaryMedium12 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle tsPrimaryMedium14 = TextStyle(
    color: Get.isDarkMode ? AppColors.lightGreen : AppColors.darkGreen,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle tsPrimaryMedium16 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle tsPrimaryMedium18 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle tsPrimaryMedium20 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle tsPrimaryMedium24 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static TextStyle tsPrimarySemiBold10 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static TextStyle tsPrimarySemiBold12 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static TextStyle tsPrimarySemiBold14 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle tsPrimarySemiBold16 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle tsPrimarySemiBold18 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static TextStyle tsPrimarySemiBold20 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static TextStyle tsPrimarySemiBold24 = TextStyle(
    color: AppColors.primary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static TextStyle tsSecondaryRegular10 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static TextStyle tsSecondaryRegular12 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle tsSecondaryRegular14 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle tsSecondaryRegular16 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle tsSecondaryRegular18 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static TextStyle tsSecondaryRegular20 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
  static TextStyle tsSecondaryRegular24 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
  static TextStyle tsSecondaryMedium10 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static TextStyle tsSecondaryMedium12 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle tsSecondaryMedium14 = TextStyle(
    color: AppColors.lightGreen,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle tsprimaryGrayishBlackMedium14 = TextStyle(
    color: AppColors.blackGrayish,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle tsprimaryGrayishBlackMedium18 = TextStyle(
    color: AppColors.blackGrayish,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle tsprimaryGrayishBlackMedium20 = TextStyle(
    color: AppColors.blackGrayish,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle tsprimarywhiteMedium14 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle tsprimarywhiteMedium20 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle tsprimarywhiteMedium18 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle tsSecondaryMedium16 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle tsSecondaryMedium18 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle tsSecondaryMedium20 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle tsSecondaryMedium24 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static TextStyle tsSecondarySemiBold10 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static TextStyle tsSecondarySemiBold12 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static TextStyle tsSecondarySemiBold14 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle tsSecondarySemiBold16 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle tsSecondarySemiBold18 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static TextStyle tsSecondarySemiBold20 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static TextStyle tsSecondarySemiBold24 = TextStyle(
    color: AppColors.secondary,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static TextStyle tsWhiteRegular10 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static TextStyle tsWhiteRegular12 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle tsWhiteRegular14 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle tsWhiteRegular16 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle tsWhiteRegular18 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static TextStyle tsWhiteRegular20 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
  static TextStyle tsWhiteRegular24 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );

  static TextStyle tsWhiteMedium10 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static TextStyle tsWhiteMedium12 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle tsWhiteMedium14 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle tsWhiteMedium16 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle tsWhiteMedium18 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle tsWhiteMedium20 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle tsWhiteMedium24 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static TextStyle tsWhiteSemiBold10 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static TextStyle tsWhiteSemiBold12 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static TextStyle tsWhiteSemiBold14 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle tsWhiteSemiBold16 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle tsWhiteSemiBold18 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static TextStyle tsWhiteSemiBold20 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static TextStyle tsWhiteSemiBold22 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );
  static TextStyle tsWhiteSemiBold24 = TextStyle(
    color: AppColors.white,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static TextStyle tsBlackRegular10 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static TextStyle tsBlackRegular12 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle tsBlackRegular14 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle tsBlackRegular16 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle tsBlackRegular18 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static TextStyle tsBlackRegular20 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
  static TextStyle tsBlackRegular24 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );

  static TextStyle tsBlackMedium10 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static TextStyle tsBlackMedium12 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle tsBlackMedium14 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle tsBlackMedium16 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle tsBlackMedium18 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle tsBlackMedium20 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle tsBlackMedium24 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static TextStyle tsBlackSemiBold10 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static TextStyle tsBlackSemiBold12 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static TextStyle tsBlackSemiBold14 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle tsBlackSemiBold16 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle tsBlackSemiBold18 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static TextStyle tsBlackSemiBold20 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static TextStyle tsBlackSemiBold24 = TextStyle(
    color: AppColors.black,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static TextStyle tsGreyRegular10 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );

  static TextStyle tsGreyRegular12 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle tsGreyRegular14 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle tsGreyRegular16 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle tsGreyRegular18 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static TextStyle tsGreyRegular20 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
  static TextStyle tsGreyRegular24 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
  static TextStyle tsGreyMedium10 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static TextStyle tsGreyMedium12 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle tsGreyMedium14 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle tsGreyMedium16 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle tsGreyMedium18 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle tsGreyMedium20 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle tsGreyMedium24 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  static TextStyle tsGreySemiBold10 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static TextStyle tsGreySemiBold12 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static TextStyle tsGreySemiBold14 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle tsGreySemiBold16 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle tsGreySemiBold18 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static TextStyle tsGreySemiBold20 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static TextStyle tsGreySemiBold24 = TextStyle(
    color: AppColors.grey,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static TextStyle tsDarkGreyRegular14 = TextStyle(
    color: AppColors.grey.shade900,
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
}
