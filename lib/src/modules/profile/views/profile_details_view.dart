import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../../modules.dart';

class ProfileDetailsView extends GetView<ProfileController> {
  const ProfileDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            splashRadius: 24,
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: AbsorbPointer(
            absorbing: true,
            child: Column(
              children: [
                SizedBox(height: 16),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.positionTextController,
                  hintText: 'Position',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.userNameTextController,
                  hintText: 'Username',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.firstNameTextController,
                  hintText: 'First Name',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.lastNameTextController,
                  hintText: 'Last Name',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.emailTextController,
                  hintText: 'Email',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.mobileTextController,
                  hintText: 'Mobile',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.dobTextController,
                  hintText: 'Date of Birth',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.genderTextController,
                  hintText: 'Gender',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.addressTextController,
                  hintText: 'Address',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.cityTextController,
                  hintText: 'City',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.pincodeTextController,
                  hintText: 'Pincode',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.stateTextController,
                  hintText: 'State',
                ),
                CommonTextField(
                  hasLabel: true,
                  controller: controller.countryTextController,
                  hintText: 'Country',
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
