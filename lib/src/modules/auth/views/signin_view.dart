import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
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
                        'assets/images/signin.png',
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
                              'Let\'s get started with\nStock trading!',
                              style: Theme.of(context).textTheme.tsMedium20,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 24),
                          Align(
                            child: Text(
                              'Please provide your mobile number, a six digit OTP will be send for verification.',
                              textAlign: TextAlign.center,
                              style: AppStyles.tsGreyRegular16,
                            ),
                          ),
                          SizedBox(height: 24),
                          Form(
                            key: formKey,
                            child: CommonTextField(
                              controller: controller.mobileTextController,
                              hintText: 'Enter your mobile number',
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              prefixIcon: Icon(
                                Icons.phone,
                                color: AppColors.grey,
                              ),
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
                          ),
                          Obx(
                            () => CommonFilledButton(
                              isLoading: controller.isLoadingStatus,
                              label: 'Continue',
                              onPressed: () {
                                bool isValid = formKey.currentState?.validate() ?? false;
                                if (isValid) controller.userSignin();
                              },
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Learn and earn from stock market trading.\nClaim your free account now!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.tsRegular16,
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
