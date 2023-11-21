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
                      SizedBox(height: 24),
                      Image.asset(
                        'assets/images/otp.png',
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(height: 36),
                      CommonCard(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.zero,
                        children: [
                          Align(
                            child: Text(
                              'Please enter your\nverification code!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.tsMedium20,
                            ),
                          ),
                          SizedBox(height: 24),
                          Align(
                            child: Text(
                              'We have sent a six digit verification\ncode to +91 ${controller.mobileTextController.text}',
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.tsGreyRegular16,
                            ),
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
                                  textStyle:
                                      Theme.of(context).textTheme.tsSemiBold20,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                focusedPinTheme: PinTheme(
                                  width: 64,
                                  height: 64,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .tsWhiteSemiBold22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.lightGreen,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                errorPinTheme: PinTheme(
                                  width: 64,
                                  height: 64,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .tsPrimarySemiBold20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
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
                              backgroundColor: Get.isDarkMode
                                  ? AppColors.darkGreen
                                  : AppColors.lightGreen,
                              label: 'Verify',
                              onPressed: controller.verifyOtp,
                              isLoading: controller.isLoadingStatus,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Didn\'t receive the code?',
                          style: Theme.of(context).textTheme.tsRegular16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24),
                      CommonOutlinedButton(
                        backgroundColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        labelColor: Get.isDarkMode
                            ? AppColors.darkGreen
                            : AppColors.lightGreen,
                        label: 'Send again',
                        onPressed: () => controller.resendSigninOtp(),
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
