import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../../modules.dart';

class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {
  late ProfileController controller;
  @override
  void initState() {
    controller = Get.find<ProfileController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          actions: [
            IconButton(
              splashRadius: 24,
              icon: controller.isEditEnabled.value ? Icon(Icons.save) : Icon(Icons.edit),
              onPressed: () {
                if (controller.isEditEnabled.value) controller.saveUserProfileDetails();
                controller.isEditEnabled.toggle();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
        body: Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: AbsorbPointer(
                absorbing: !controller.isEditEnabled.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    CommonTextField(
                      isDisabled: true,
                      controller: controller.positionTextController,
                      hintText: 'Position',
                    ),
                    CommonTextField(
                      isDisabled: true,
                      controller: controller.userNameTextController,
                      hintText: 'Username',
                    ),
                    Text(
                      'Personal Information',
                      textAlign: TextAlign.start,
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
                      controller: controller.emailTextController,
                      hintText: 'Email',
                    ),
                    CommonTextField(
                      controller: controller.mobileTextController,
                      hintText: 'Mobile',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonDropdown(
                            color: AppColors.grey.withOpacity(0.1),
                            hint: 'Gender',
                            value: controller.genderValue,
                            dropdownItems: controller.dropdownItems,
                            onChanged: (value) => setState(() => controller.genderValue = value),
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
                    Text(
                      'Location',
                      textAlign: TextAlign.start,
                      style: AppStyles.tsGreyMedium16,
                    ),
                    SizedBox(height: 12),
                    CommonTextField(
                      prefixIcon: Icon(Icons.home),
                      controller: controller.addressTextController,
                      hintText: 'Address',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            prefixIcon: Icon(Icons.location_city),
                            controller: controller.cityTextController,
                            hintText: 'City',
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CommonTextField(
                            controller: controller.pincodeTextController,
                            hintText: 'Pincode',
                            prefixIcon: Icon(Icons.pin),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            prefixIcon: Icon(Icons.location_on),
                            controller: controller.stateTextController,
                            hintText: 'State',
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CommonTextField(
                            prefixIcon: Icon(Icons.public),
                            controller: controller.countryTextController,
                            hintText: 'Country',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
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
