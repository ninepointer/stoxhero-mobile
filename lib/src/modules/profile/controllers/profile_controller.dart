import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stoxhero/src/base/base.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() => Get.put(ProfileController());
}

class ProfileController extends BaseController<ProfileRepository> {
  File? image;
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;
  final isEditEnabled = false.obs;

  String? genderValue;
  List<String> dropdownItems = ['Male', 'Female', 'Other'];

  final userNameTextController = TextEditingController();
  final positionTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final pincodeTextController = TextEditingController();
  final stateTextController = TextEditingController();
  final countryTextController = TextEditingController();
  final selectedDOBDateTime = ''.obs;

  void loadData() {
    loadProfileDetails();
  }

  String formatDate(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedString;
    } else {
      return '';
    }
  }

  void loadProfileDetails() {
    userDetails(AppStorage.getUserDetails());
    userNameTextController.text = userDetails.value.employeeid ?? '';
    positionTextController.text = userDetails.value.designation ?? '';
    firstNameTextController.text = userDetails.value.firstName ?? '';
    lastNameTextController.text = userDetails.value.lastName ?? '';
    emailTextController.text = userDetails.value.email ?? '';
    mobileTextController.text = userDetails.value.mobile ?? '';
    dobTextController.text = formatDate(userDetails.value.dob);
    genderValue = userDetails.value.gender ?? '';
    addressTextController.text = userDetails.value.address ?? '';
    cityTextController.text = userDetails.value.city ?? '';
    pincodeTextController.text = userDetails.value.pincode ?? '';
    stateTextController.text = userDetails.value.state ?? '';
    countryTextController.text = userDetails.value.country ?? '';
  }

  String getUserFullName() {
    String firstName = userDetailsData.firstName ?? '';
    String lastName = userDetailsData.lastName ?? '';
    String fullName = '$firstName $lastName';
    return fullName.capitalize!;
  }

  void showDateRangePicker(BuildContext context, {bool isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      String date = DateFormat("dd-MM-yyyy").format(pickedDate);
      dobTextController.text = date;
      selectedDOBDateTime(pickedDate.toString());
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick Image $e');
    }
  }

  Future saveUserProfileDetails() async {
    isLoading(true);

    Map<String, dynamic> data = {
      "first_name": firstNameTextController.text,
      "last_name": lastNameTextController.text,
      "email": emailTextController.text,
      "mobile": mobileTextController.text,
      "gender": genderValue,
      "dob": dobTextController.text,
      "address": addressTextController.text,
      "city": cityTextController.text,
      "pincode": pincodeTextController.text,
      "state": stateTextController.text,
      "country": countryTextController.text,
    };

    try {
      final RepoResponse<GenericResponse> response = await repository.updateUserDetails(data);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          final loginDetailsResponse = await Get.find<AuthRepository>().loginDetails();
          if (loginDetailsResponse.data != null) {
            await AppStorage.setUserDetails(loginDetailsResponse.data!);
          }
        }
        log('AppStorage.getUserDetails : ${AppStorage.getUserDetails().toJson()}');
        SnackbarHelper.showSnackbar(response.data?.message);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Save: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }

    isLoading(false);
  }
}
