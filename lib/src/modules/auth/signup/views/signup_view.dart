import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';
import '../signup_index.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

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
                        'Join us now to learn and earn from the Stock Market!',
                        style: AppStyles.tsWhiteRegular20.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Please provide your details, confirmation will be send on the given email.',
                        style: AppStyles.tsGreyRegular16,
                      ),
                      SizedBox(height: 24),
                      CommonTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter your first name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColors.netural.shade100,
                        ),
                      ),
                      CommonTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter your last name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColors.netural.shade100,
                        ),
                      ),
                      CommonTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter your email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.netural.shade100,
                        ),
                      ),
                      CommonTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter your mobile number',
                        prefixIcon: Icon(
                          Icons.phone,
                          color: AppColors.netural.shade100,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                        label: 'Create account',
                        onPressed: () => Get.toNamed(AppRoutes.home),
                      ),
                      Spacer(),
                      SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Already have an account?',
                          style: AppStyles.tsWhiteRegular16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24),
                      CommonOutlinedButton(
                        label: 'Sign In',
                        onPressed: () => Get.toNamed(AppRoutes.signin),
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
