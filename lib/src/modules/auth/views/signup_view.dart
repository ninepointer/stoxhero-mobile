import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late AuthController controller;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    controller = Get.find<AuthController>();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Center(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 24),
                        Image.asset(
                          'assets/images/signup.png',
                          width: 120,
                          height: 120,
                        ),
                        SizedBox(height: 24),
                        CommonCard(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.zero,
                          children: [
                            Align(
                              child: Text(
                                'Join us now to learn and earn\nfrom the Stock Market!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.tsMedium20,
                              ),
                            ),
                            SizedBox(height: 36),
                            Align(
                              child: Text(
                                'Please provide your details, confirmation will be send on the given email.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.tsGreyRegular16,
                              ),
                            ),
                            SizedBox(height: 24),
                            CommonTextField(
                              controller: controller.firstNameTextController,
                              hintText: 'Enter your first name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: AppColors.grey,
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length == 0) {
                                  return 'This field is required!';
                                }
                                return null;
                              },
                            ),
                            CommonTextField(
                              controller: controller.lastNameTextController,
                              hintText: 'Enter your last name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: AppColors.grey,
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length == 0) {
                                  return 'This field is required!';
                                }
                                return null;
                              },
                            ),
                            CommonTextField(
                              controller: controller.emailTextController,
                              hintText: 'Enter your email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: AppColors.grey,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length == 0) {
                                  return 'This field is required!';
                                } else if (!value.isEmail) {
                                  return 'Please enter valid email';
                                }
                                return null;
                              },
                            ),
                            CommonTextField(
                              controller: controller.mobileTextController,
                              hintText: 'Enter your mobile number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: AppColors.grey,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                RegExp regExp = RegExp(r'^[6-9]\d{9}$');
                                if (value == null || value.isEmpty || value.length == 0) {
                                  return 'This field is required!';
                                } else if (value.length == 10) if (!regExp.hasMatch(value)) {
                                  return 'Please enter valid mobile number!';
                                }
                                return null;
                              },
                            ),
                            GestureDetector(
                              onTap: () => controller.showDateRangePicker(context),
                              child: CommonTextField(
                                isDisabled: true,
                                controller: controller.dobTextController,
                                hintText: 'Date of Birth',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.grey,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.length == 0) {
                                    return 'This field is required!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            CommonTextField(
                              controller: controller.referralTextController,
                              hintText: 'Referral Code',
                              prefixIcon: Icon(
                                Icons.redeem_rounded,
                                color: AppColors.grey,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            CommonFilledButton(
                              backgroundColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                              label: 'Create account',
                              onPressed: () {
                                bool isValid = formKey.currentState?.validate() ?? false;
                                if (isValid) controller.userSignup();
                              },
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(height: 36),
                        Center(
                          child: Text(
                            'Already have an account?',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.tsRegular16,
                          ),
                        ),
                        SizedBox(height: 24),
                        CommonOutlinedButton(
                          backgroundColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                          labelColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                          label: 'Sign In',
                          onPressed: () => Get.toNamed(AppRoutes.signin),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
