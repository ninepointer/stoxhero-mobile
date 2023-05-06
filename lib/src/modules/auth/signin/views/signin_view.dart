import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';
import '../signin_index.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLogoWidget(logoSize: 100),
                      SizedBox(height: 50),
                      Text(
                        'Let\'s get started with Stock trading!',
                        style: AppStyles.tsWhiteRegular20.copyWith(
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Please provide your mobile number, a six digit OTP will be send for verification.',
                        style: AppStyles.tsGreyRegular16,
                      ),
                      SizedBox(height: 24),
                      CommonTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter your mobile number',
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        prefixIcon: Icon(
                          Icons.phone,
                          color: AppColors.netural.shade100,
                        ),
                        validator: (value) {
                          RegExp regExp = RegExp(r'^[6-9]\d{9}$');
                          if (value == null || value.isEmpty || value.length == 0) {
                            return 'This field is required!';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid mobile number!';
                          }
                          return null;
                        },
                      ),
                      CommonFilledButton(
                        label: 'Continue',
                        onPressed: () {},
                      ),
                      Spacer(),
                      SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Learn and earn from stock market trading.\nClaim your free account now!',
                          style: AppStyles.tsWhiteRegular16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24),
                      CommonOutlinedButton(
                        label: 'Create account',
                        onPressed: () => Get.toNamed(AppRoutes.signup),
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
