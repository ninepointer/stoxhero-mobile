import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/careers/controllers/career_controller.dart';

import '../../../core/widgets/common_dropdown.dart';

class CareerForm extends GetView<CareerController> {
  const CareerForm({Key? key}) : super(key: key);

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
                style: AppStyles.tsWhiteMedium14,
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
              CommonDropdown(),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Trading Exp',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.showDateRangePicker(context),
                      child: CommonTextField(
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
              CommonTextField(
                hintText: 'From where you hear about us ?',
              ),
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
