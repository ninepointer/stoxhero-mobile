import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    controller.loadData();
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
        () => Visibility(
          visible: controller.isFormLoadingStatus,
          child: CommonLoader(),
          replacement: Container(
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
                    // CommonTextField(
                    //   prefixIcon: Icon(Icons.school),
                    //   controller: controller.collegeNameTextController,
                    //   hintText: 'College Name',
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your college name';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    Autocomplete<CollegeData>(
                      displayStringForOption: (option) => option.collegeName ?? '-',
                      fieldViewBuilder: (
                        BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted,
                      ) {
                        return TextFormField(
                          cursorColor: Colors.white,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter item name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'College Name',
                            contentPadding: EdgeInsets.all(14),
                            filled: true,
                            fillColor: AppColors.grey.withOpacity(.1),
                            hintStyle: AppStyles.tsGreyRegular14,
                            prefixIconColor: AppColors.grey,
                            suffixIconColor: AppColors.grey,
                            errorStyle: AppStyles.tsGreyRegular12.copyWith(
                              color: AppColors.danger.shade700,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.primary,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.primary.shade700,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.danger.shade700,
                              ),
                            ),
                          ),
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                        );
                      },
                      optionsBuilder: (TextEditingValue fruitTextEditingValue) {
                        if (fruitTextEditingValue.text == '') {
                          return const Iterable<CollegeData>.empty();
                        }
                        return controller.collegeList.where((CollegeData data) {
                          return data.collegeName!.contains(fruitTextEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (CollegeData value) {
                        controller.collegeDetails(value);
                      },
                    ),
                    SizedBox(height: 12),
                    CommonDropdown(
                      color: AppColors.grey.withOpacity(0.1),
                      hint: 'Course',
                      value: controller.courseSelectedValue,
                      dropdownItems: controller.courseList,
                      onChanged: (value) => setState(() => controller.courseSelectedValue = value!),
                    ),
                    SizedBox(height: 12),
                    CommonTextField(
                      padding: EdgeInsets.zero,
                      hintText: 'Year of passing out',
                      controller: controller.passoutYearProfileTextController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
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
                          child: AbsorbPointer(
                            absorbing: controller.userDetails.value.dob == null ||
                                controller.userDetails.value.dob!.isNotEmpty,
                            child: GestureDetector(
                              onTap: () => controller.showDateRangePicker(context),
                              child: CommonTextField(
                                isDisabled: true,
                                padding: EdgeInsets.zero,
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
