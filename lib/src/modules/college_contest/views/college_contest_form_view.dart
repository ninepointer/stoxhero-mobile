import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoxhero/src/app/app.dart';

class CollegeContestFormView extends StatefulWidget {
  final String? contestId;
  const CollegeContestFormView({Key? key, this.contestId}) : super(key: key);

  @override
  State<CollegeContestFormView> createState() => _CollegeContestFormViewState();
}

class _CollegeContestFormViewState extends State<CollegeContestFormView> {
  late CollegeContestController controller;
  @override
  void initState() {
    controller = Get.find<CollegeContestController>();
    controller.isOtpVisible(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Career Form'),
      ),
      body: Obx(
        () => Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 4),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!controller.isOtpVisible.value) ...[
                  Text(
                    'Personal Information',
                    style: AppStyles.tsGreyMedium16,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          prefixIcon: Icon(Icons.person),
                          controller: controller.firstNameTextController,
                          hintText: 'First Name',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CommonTextField(
                          prefixIcon: Icon(Icons.person),
                          controller: controller.lastNameTextController,
                          hintText: 'Last Name',
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(
                    prefixIcon: Icon(Icons.mail),
                    controller: controller.emailTextController,
                    hintText: 'Email',
                  ),
                  CommonTextField(
                    controller: controller.mobileTextController,
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Mobile',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  CommonTextField(
                    prefixIcon: Icon(Icons.school),
                    controller: controller.collegeNameTextController,
                    hintText: 'College Name',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonDropdown(
                          color: AppColors.grey.withOpacity(0.1),
                          hint: 'Experience',
                          value: controller.experienceSelectedValue,
                          dropdownItems: controller.experienceDropdown,
                          onChanged: (value) => setState(() => controller.experienceSelectedValue = value!),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.showDateRangePicker(context),
                          child: CommonTextField(
                            padding: EdgeInsets.zero,
                            isDisabled: true,
                            controller: controller.dobTextController,
                            hintText: 'Date of Birth',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  CommonDropdown(
                    color: AppColors.grey.withOpacity(0.1),
                    hint: 'Hear about us',
                    value: controller.hearAboutSelectedValue,
                    dropdownItems: controller.hearAboutDropdown,
                    onChanged: (value) => setState(
                      () => controller.hearAboutSelectedValue = value!,
                    ),
                  ),
                  SizedBox(height: 12),
                ],
                if (controller.isOtpVisible.value)
                  CommonTextField(
                    prefixIcon: Icon(Icons.password),
                    hintText: 'OTP',
                    controller: controller.otpTextController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                  ),
                CommonFilledButton(
                  backgroundColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                  label: 'Submit',
                  onPressed: () {
                    print(controller.isOtpVisible.value);
                    controller.isOtpVisible.value
                        ? controller.validateCollegeContestOtp(widget.contestId)
                        : controller.submitCollegeContestForm(widget.contestId);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
