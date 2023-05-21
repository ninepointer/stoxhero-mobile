import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class OtpView extends GetView<AuthController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AppLogoWidget(logoSize: 80),
                      SizedBox(height: 50),
                      Text(
                        'Please enter your verification code!',
                        textAlign: TextAlign.center,
                        style: AppStyles.tsWhiteMedium20.copyWith(
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'We have sent a six digit verification code to \n+91 ${controller.mobileTextController.text}',
                        textAlign: TextAlign.center,
                        style: AppStyles.tsGreyRegular16,
                      ),
                      SizedBox(height: 24),
                      Form(
                        key: controller.otpFormKey,
                        child: Center(
                          child: Pinput(
                            length: 6,
                            controller: controller.otpTextController,
                            pinAnimationType: PinAnimationType.fade,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onCompleted: (value) => controller.verifyOtp(),
                            defaultPinTheme: PinTheme(
                              width: 64,
                              height: 64,
                              textStyle: AppStyles.tsWhiteSemiBold22,
                              decoration: BoxDecoration(
                                color: AppColors.netural.shade700,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              width: 64,
                              height: 64,
                              textStyle: AppStyles.tsWhiteSemiBold22,
                              decoration: BoxDecoration(
                                color: AppColors.netural.shade700,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            errorPinTheme: PinTheme(
                              width: 64,
                              height: 64,
                              textStyle: AppStyles.tsWhiteSemiBold22,
                              decoration: BoxDecoration(
                                color: AppColors.netural.shade700,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.danger.shade900,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ErrorMessages.required;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Obx(
                        () => CommonFilledButton(
                          label: 'Verify',
                          onPressed: controller.verifyOtp,
                          isLoading: controller.isLoadingStatus,
                        ),
                      ),
                      Spacer(),
                      SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Didn\'t received the code?',
                          style: AppStyles.tsWhiteRegular16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24),
                      CommonOutlinedButton(
                        label: 'Send again',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
