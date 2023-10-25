import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() => Get.put(AuthController());
}

class AuthController extends BaseController<AuthRepository> {
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final otpTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final referralTextController = TextEditingController();

  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isSignup = false.obs;

  final token = ''.obs;

  void verifyOtp() => isSignup.value ? verifySignupOtp() : verifySigninOtp();

  void showDateRangePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String date = DateFormat("dd-MM-yyyy").format(pickedDate);
      dobTextController.text = date;
    }
  }

  Future userSignin() async {
    isLoading(true);

    FocusScope.of(Get.context!).unfocus();

    PhoneLoginRequest data = PhoneLoginRequest(
      mobile: mobileTextController.text,
    );

    try {
      final RepoResponse<GenericResponse> response = await repository.phoneLogin(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          Get.toNamed(AppRoutes.otp);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future verifySigninOtp() async {
    isLoading(true);

    FocusScope.of(Get.context!).unfocus();

    VerifySigninRequest data = VerifySigninRequest(
      mobile: mobileTextController.text,
      mobileOtp: otpTextController.text,
    );

    try {
      final RepoResponse<VerifyPhoneLoginResponse> response = await repository.verifySigninOtp(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          token(response.data?.token);
          await AppStorage.setToken(response.data?.token);
          log('AppStorage.getToken : ${AppStorage.getToken()}');
          await getUserDetails();
          clearForm();
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future verifySignupOtp() async {
    isLoading(true);

    FocusScope.of(Get.context!).unfocus();

    VerifySignupRequest data = VerifySignupRequest(
      firstName: firstNameTextController.text,
      lastName: lastNameTextController.text,
      email: emailTextController.text,
      mobile: mobileTextController.text,
      mobileOtp: otpTextController.text,
      referrerCode: "",
    );

    try {
      final RepoResponse<GenericResponse> response = await repository.verifySignupOtp(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          isSignup(false);
          Get.offAllNamed(AppRoutes.signin);
          SnackbarHelper.showSnackbar(response.data?.message!);
          clearForm();
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  Future userSignup() async {
    isLoading(true);
    DateTime date = DateFormat('dd-MM-yyyy').parse(dobTextController.text);
    SignupRequest data = SignupRequest(
      firstName: firstNameTextController.text,
      lastName: lastNameTextController.text,
      email: emailTextController.text,
      mobile: mobileTextController.text,
      dob: DateFormat('yyyy-MM-dd').format(date),
      referrerCode: "",
    );

    try {
      final RepoResponse<GenericResponse> response = await repository.userSignup(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          isSignup(true);
          Get.toNamed(AppRoutes.otp);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }

    isLoading(false);
  }

  Future getUserDetails({bool navigate = true}) async {
    isLoading(true);
    try {
      final response = await repository.loginDetails();
      if (response.data != null) {
        await AppStorage.setUserDetails(response.data ?? LoginDetailsResponse());
        Get.find<HomeController>().loadUserDetails();
        if (navigate) {
          await SocketService().initSocket();
          Get.offAllNamed(AppRoutes.home);
        }
        log('App ${AppStorage.getToken()}');
      } else {
        if (navigate) Get.offAllNamed(AppRoutes.signin);
        SnackbarHelper.showSnackbar(response.error?.message);
        log('App ${AppStorage.getToken()}');
        log('App ${AppStorage.getUserDetails().toJson()}');
      }
    } catch (e) {
      log(e.toString());
      Get.offAllNamed(AppRoutes.signin);
    }
    isLoading(false);
  }

  Future resendSigninOtp() async {
    isLoading(true);

    FocusScope.of(Get.context!).unfocus();

    PhoneLoginRequest data = PhoneLoginRequest(
      mobile: mobileTextController.text,
    );

    try {
      final RepoResponse<GenericResponse> response = await repository.resendSigninOtp(
        data.toJson(),
      );
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          SnackbarHelper.showSnackbar(response.data?.message);
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log(e.toString());
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isLoading(false);
  }

  void clearForm() {
    firstNameTextController.clear();
    lastNameTextController.clear();
    emailTextController.clear();
    mobileTextController.clear();
    otpTextController.clear();
  }
}
