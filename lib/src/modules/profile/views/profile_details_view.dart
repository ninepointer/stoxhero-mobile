import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class ProfileDetailsView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          actions: [
            IconButton(
              splashRadius: 24,
              icon: controller.isEditEnabled.value
                  ? Icon(Icons.save)
                  : Icon(Icons.edit),
              onPressed: () {
                if (controller.isEditEnabled.value)
                  controller.saveUserProfileDetails();
                controller.isEditEnabled.toggle();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
        body: Visibility(
          visible: controller.isProfileLoadingStatus,
          child: ListViewShimmer(
            itemCount: 10,
            shimmerCard: SmallCardShimmer(),
          ),
          replacement: Container(
            margin: EdgeInsets.only(top: 4),
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.0306,
              ).copyWith(bottom: 100),
              child: AbsorbPointer(
                absorbing: !controller.isEditEnabled.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Information',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0204),
                    Text(
                      'Position',
                      style: Theme.of(context).textTheme.tsGreyMedium12,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0102,
                    ),
                    CommonTextField(
                      isDisabled: true,
                      controller: controller.positionTextController,
                      hintText: 'Position',
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.width * 0.0204),
                    ),
                    Text(
                      'Username',
                      style: Theme.of(context).textTheme.tsGreyMedium12,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102),
                    CommonTextField(
                      isDisabled: true,
                      controller: controller.userNameTextController,
                      hintText: 'Username',
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.width * 0.0204),
                    ),
                    Text(
                      'Personal Information',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Name',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.0102),
                              CommonTextField(
                                isDisabled: controller.isKYCApproved,
                                prefixIcon: Icon(Icons.person),
                                controller: controller.firstNameTextController,
                                hintText: 'First Name',
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.0204),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0306,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Last Name',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.0102),
                              CommonTextField(
                                isDisabled: controller.isKYCApproved,
                                prefixIcon: Icon(Icons.person),
                                controller: controller.lastNameTextController,
                                hintText: 'Last Name',
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.0204),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.tsGreyMedium12,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0102,
                    ),
                    CommonTextField(
                      isDisabled: controller.isKYCApproved,
                      controller: controller.emailTextController,
                      hintText: 'Email',
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width * 0.0204,
                      ),
                    ),
                    Text(
                      'Mobile',
                      style: Theme.of(context).textTheme.tsGreyMedium12,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0102,
                    ),
                    CommonTextField(
                      controller: controller.mobileTextController,
                      hintText: 'Mobile',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width * 0.0204,
                      ),
                    ),
                    Text(
                      'WhatsApp',
                      style: Theme.of(context).textTheme.tsGreyMedium12,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102),
                    CommonTextField(
                      controller: controller.whatsAppTextController,
                      hintText: 'WhatsApp',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.width * 0.0204),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.0102,
                              ),
                              CommonDropdown(
                                color: AppColors.grey.withOpacity(0.1),
                                hint: 'Gender',
                                value: controller.genderValue,
                                dropdownItems: controller.dropdownItems,
                                onChanged: (value) =>
                                    controller.genderValue = value,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0306,
                        ),
                        Flexible(
                          child: AbsorbPointer(
                            absorbing: controller.isKYCApproved,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DOB',
                                  style: Theme.of(context)
                                      .textTheme
                                      .tsGreyMedium12,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.0102),
                                GestureDetector(
                                  onTap: () =>
                                      controller.showDateRangePicker(context),
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Text(
                      'Profile Photo',
                      style: Theme.of(context).textTheme.tsGreyMedium12,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102),
                    CommonImageUpload(
                      label: 'Profile Photo',
                      file: controller.profilePhotoFile.value,
                      selectFile: () => controller.filePicker(
                        KycDocumentType.profilePhoto,
                      ),
                      removeFile: () => controller.filePicker(
                        KycDocumentType.profilePhoto,
                        removeFile: true,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Text(
                      'Location',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0306,
                    ),
                    Text(
                      'Address',
                      style: Theme.of(context).textTheme.tsGreyMedium12,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102),
                    CommonTextField(
                      prefixIcon: Icon(Icons.home),
                      controller: controller.addressTextController,
                      hintText: 'Address',
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.width * 0.0204),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.0204,
                              ),
                              CommonTextField(
                                prefixIcon: Icon(Icons.location_city),
                                controller: controller.cityTextController,
                                hintText: 'City',
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.0204),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0306,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pin Code',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.0102),
                              CommonTextField(
                                controller: controller.pincodeTextController,
                                hintText: 'Pincode',
                                prefixIcon: Icon(Icons.pin),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.0204),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'State',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.0102),
                              CommonTextField(
                                prefixIcon: Icon(Icons.location_on),
                                controller: controller.stateTextController,
                                hintText: 'State',
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.0204),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0306,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Country',
                                style:
                                    Theme.of(context).textTheme.tsGreyMedium12,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.0102),
                              CommonTextField(
                                prefixIcon: Icon(Icons.public),
                                controller: controller.countryTextController,
                                hintText: 'Country',
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.0204),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
