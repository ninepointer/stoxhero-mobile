import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/careers/controllers/career_controller.dart';

class CareerForm extends StatefulWidget {
  const CareerForm({Key? key}) : super(key: key);

  @override
  State<CareerForm> createState() => _CareerFormState();
}

class _CareerFormState extends State<CareerForm> {
  late CareerController controller;

  @override
  void initState() {
    controller = Get.find<CareerController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Career Form'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                controller: controller.lastNameTextController,
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
              CommonDropdown(
                color: AppColors.grey.withOpacity(0.1),
                hint: 'College Name',
                value: controller.selectedValue3,
                dropdownItems: controller.dropdownItems3,
                onChanged: (value) => setState(() => controller.selectedValue1 = value!),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CommonDropdown(
                      color: AppColors.grey.withOpacity(0.1),
                      hint: 'Experience',
                      value: controller.selectedValue1,
                      dropdownItems: controller.dropdownItems1,
                      onChanged: (value) => setState(() => controller.selectedValue1 = value!),
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
                value: controller.selectedValue2,
                dropdownItems: controller.dropdownItems2,
                onChanged: (value) => setState(() => controller.selectedValue2 = value!),
              ),
              SizedBox(height: 12),
              CommonTextField(
                prefixIcon: Icon(Icons.mail),
                hintText: 'LinkedIn Profile Link',
              ),
              CommonTextField(
                prefixIcon: Icon(Icons.password),
                hintText: 'OTP',
              ),
              CommonFilledButton(
                label: 'Submit',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
