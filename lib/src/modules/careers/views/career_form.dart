import 'package:flutter/material.dart';

import '../../../app/app.dart';

class CareerForm extends StatefulWidget {
  final String? careerId;
  const CareerForm({Key? key, this.careerId}) : super(key: key);

  @override
  State<CareerForm> createState() => _CareerFormState();
}

class _CareerFormState extends State<CareerForm> {
  late CareerController controller;
  @override
  void initState() {
    controller = Get.find<CareerController>();
    controller.isOtpVisible(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Career Form'),
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 4),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Information',
                  style: AppStyles.tsGreyMedium16,
                ),
                SizedBox(height: 12),
                CommonTextField(
                  prefixIcon: Icon(Icons.school),
                  controller: controller.collegeNameTextController,
                  hintText: 'College Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your college name';
                    }
                    return null;
                  },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your DOB';
                            }
                            return null;
                          },
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
                CommonTextField(
                  prefixIcon: Icon(Icons.mail),
                  hintText: 'LinkedIn Profile Link',
                  controller: controller.linkedInProfileTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your linkedIn profile link';
                    }
                    return null;
                  },
                ),
                CommonFilledButton(
                    label: 'Submit',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.careerApply(widget.careerId);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


                // Row(
                //   children: [
                //     Expanded(
                //       child: CommonTextField(
                //         prefixIcon: Icon(Icons.person),
                //         controller: controller.firstNameTextController,
                //         hintText: 'First Name',
                //       ),
                //     ),
                //     SizedBox(width: 12),
                //     Expanded(
                //       child: CommonTextField(
                //         prefixIcon: Icon(Icons.person),
                //         controller: controller.lastNameTextController,
                //         hintText: 'Last Name',
                //       ),
                //     ),
                //   ],
                // ),
                // CommonTextField(
                //   prefixIcon: Icon(Icons.mail),
                //   controller: controller.emailTextController,
                //   hintText: 'Email',
                // ),
                // CommonTextField(
                //   controller: controller.mobileTextController,
                //   prefixIcon: Icon(Icons.phone),
                //   hintText: 'Mobile',
                //   keyboardType: TextInputType.number,
                //   inputFormatters: [
                //     LengthLimitingTextInputFormatter(10),
                //     FilteringTextInputFormatter.digitsOnly,
                //   ],
                // ),
                // CommonDropdown(
                //   color: AppColors.grey.withOpacity(0.1),
                //   hint: 'College Name',
                //   value: controller.selectedValue3,
                //   dropdownItems: controller.dropdownItems3,
                //   onChanged: (value) => setState(() => controller.selectedValue1 = value!),
                // ),