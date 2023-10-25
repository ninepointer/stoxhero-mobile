import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';

import '../../../base/base.dart';

class CareerBinding implements Bindings {
  @override
  void dependencies() => Get.put(CareerController());
}

class CareerController extends BaseController<CareerRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isOtpVisible = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final collegeNameTextController = TextEditingController();
  final otpTextController = TextEditingController();
  final linkedInProfileTextController = TextEditingController();

  final careerList = <CareerList>[].obs;
  final careerDetails = CareerList().obs;

  final selectedDOBDateTime = ''.obs;

  void loadData() {
    userDetails.value = AppStorage.getUserDetails();
    dobTextController.text = FormatHelper.formatDateOfBirthToIST(userDetails.value.dob);
  }

  void showDateRangePicker(BuildContext context, {bool isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String date = DateFormat("dd-MM-yyyy").format(pickedDate);
      dobTextController.text = date;
      selectedDOBDateTime(pickedDate.toString());
    }
  }

  String? experienceSelectedValue;
  String? hearAboutSelectedValue;

  final List<String> experienceDropdown = ['Yes', 'No'];
  final List<String> hearAboutDropdown = [
    'LinkedIn',
    'Facebook',
    'Instagram',
    'Twitter',
    'Google',
    'Friend',
    'Others',
  ];
  final List<String> dropdownItems3 = [];

  Future getCareerList(String? type) async {
    isLoading(true);
    try {
      final RepoResponse<CareerResponse> response = await repository.getCareerList(type);
      if (response.data != null) {
        careerList(response.data?.data ?? []);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Career: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  // void validateCarrerOtp(String? careerId) async {
  //   isLoading(true);
  //   if (otpTextController.text.isNotEmpty) {
  //     FocusScope.of(Get.context!).unfocus();

  //     CareerFormRequest data = CareerFormRequest(
  //       firstName: firstNameTextController.text,
  //       lastName: lastNameTextController.text,
  //       email: emailTextController.text,
  //       mobile: mobileTextController.text,
  //       collegeName: collegeNameTextController.text,
  //       dob: selectedDOBDateTime.value,
  //       priorTradingExperience: experienceSelectedValue,
  //       source: hearAboutSelectedValue,
  //       linkedInProfileLink: linkedInProfileTextController.text,
  //       mobileOtp: otpTextController.text,
  //       career: careerId,
  //       campaignCode: "",
  //     );

  //     try {
  //       final RepoResponse response = await repository.validateCareerOtp(
  //         data.toJson(),
  //       );
  //       if (response.data != null) {
  //         Get.back();
  //         SnackbarHelper.showSnackbar(response.data['info']);
  //       }
  //     } catch (e) {
  //       log(e.toString());
  //       SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
  //     }
  //   }
  //   isLoading(false);
  // }

  void clearForm() {
    collegeNameTextController.clear();
    selectedDOBDateTime.value = '';
    experienceSelectedValue = experienceSelectedValue;
    hearAboutSelectedValue = hearAboutSelectedValue;
    linkedInProfileTextController.clear();
  }

  void careerApply(String? careerId) async {
    isLoading(true);

    FocusScope.of(Get.context!).unfocus();
    DateTime date = DateFormat('dd-MM-yyyy').parse(dobTextController.text);
    CareerFormRequest data = CareerFormRequest(
      collegeName: collegeNameTextController.text,
      dob: DateFormat('yyyy-MM-dd').format(date),
      priorTradingExperience: experienceSelectedValue,
      source: hearAboutSelectedValue,
      linkedInProfileLink: linkedInProfileTextController.text,
      career: careerId,
      campaignCode: " ",
    );

    try {
      final RepoResponse<GenericResponse> response = await repository.careerApply(
        data.toJson(),
      );
      if (response.data?.status?.toLowerCase() == "success") {
        Get.back();
        SnackbarHelper.showSnackbar('Thank you for Applying');
        clearForm();
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }
}
