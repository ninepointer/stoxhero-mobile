import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:stoxhero/src/base/base.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';
import '../../modules.dart';

enum KycDocumentType {
  aadhaarCardFront,
  aadhaarCardBack,
  panCard,
  passportPhoto,
  addressProof,
  profilePhoto,
}

class ProfileBinding implements Bindings {
  @override
  void dependencies() => Get.put(ProfileController());
}

class ProfileController extends BaseController<ProfileRepository> {
  final userDetails = LoginDetailsResponse().obs;
  LoginDetailsResponse get userDetailsData => userDetails.value;
  final isLoading = false.obs;
  bool get isLoadingStatus => isLoading.value;

  final isProfileLoading = false.obs;
  bool get isProfileLoadingStatus => isProfileLoading.value;

  final isBankLoading = false.obs;
  bool get isBankLoadingStatus => isBankLoading.value;

  final isverifyKycLoading = false.obs;
  bool get isverifyKycLoadingStatus => isverifyKycLoading.value;

  bool get isKYCApproved => userDetails.value.kYCStatus == 'Approved';

  final isOTPGenerated = false.obs;
  bool get isOTPGeneratedStatus => isOTPGenerated.value;

  final isEditEnabled = false.obs;
  final isKYCEditEnabled = false.obs;
  File? image;

  String? genderValue;
  List<String> dropdownItems = ['Male', 'Female', 'Other'];
  final selectedStates = ''.obs;

  final otpFormKey = GlobalKey<FormState>();
  final otpTextController = TextEditingController();

  final kycAadhaarNumberTextController = TextEditingController();
  final kycPanCardNumberTextController = TextEditingController();
  final kycAccountNumberTextController = TextEditingController();
  final kycIfscCodeTextController = TextEditingController();

  final userNameTextController = TextEditingController();
  final positionTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final whatsAppTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final pincodeTextController = TextEditingController();
  final stateTextController = TextEditingController();
  final countryTextController = TextEditingController();
  final selectedDOBDateTime = ''.obs;
  final upiIdTextController = TextEditingController();
  final googlePayNumberTextController = TextEditingController();
  final phonePeNumberTextController = TextEditingController();
  final paytmNumberTextController = TextEditingController();

  final nameAsPerBankAccountTextController = TextEditingController();
  final bankNameTextController = TextEditingController();
  final accountNumberTextController = TextEditingController();
  final ifscCodeTextController = TextEditingController();

  final verifyKYCOtpController = TextEditingController();

  final aadhaarCardNumberTextController = TextEditingController();
  final panCardNumberTextController = TextEditingController();
  final drivingLicenseNumberTextController = TextEditingController();
  final passportCardNumberTextController = TextEditingController();

  final verifyKYCGenrateOtpDataList = VerifyKYCGenrateOTPData().obs;

  final Rx<PlatformFile?> aadhaarCardFrontFile =
      PlatformFile(name: '', size: 0).obs;
  final Rx<PlatformFile?> aadhaarCardBackFile =
      PlatformFile(name: '', size: 0).obs;
  final Rx<PlatformFile?> panCardFile = PlatformFile(name: '', size: 0).obs;
  final Rx<PlatformFile?> passportSizePhotoFile =
      PlatformFile(name: '', size: 0).obs;
  final Rx<PlatformFile?> addressProofFile =
      PlatformFile(name: '', size: 0).obs;
  final Rx<PlatformFile?> profilePhotoFile =
      PlatformFile(name: '', size: 0).obs;

  List<String> states = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu & Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
  ];

  final isVerifyButtonVisible = false.obs;

  void showGenerateOTPButton() {
    isVerifyButtonVisible.value = false;
  }

  void showVerifyButton() {
    isVerifyButtonVisible.value = true;
  }

  void loadData() {
    loadProfileDetails();
    loadBankDetails();
    isEditEnabled(false);
  }

  String getUserFullName() {
    String firstName = userDetailsData.firstName ?? '';
    String lastName = userDetailsData.lastName ?? '';
    String fullName = '$firstName $lastName';
    return fullName.capitalize!;
  }

  void showDateRangePicker(BuildContext context,
      {bool isStartDate = true}) async {
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

  void loadProfileDetails() async {
    isProfileLoading(true);
    userDetails(AppStorage.getUserDetails());
    userNameTextController.text = userDetails.value.employeeid ?? '';
    positionTextController.text = userDetails.value.designation ?? '';
    firstNameTextController.text = userDetails.value.firstName ?? '';
    lastNameTextController.text = userDetails.value.lastName ?? '';
    emailTextController.text = userDetails.value.email ?? '';
    mobileTextController.text = userDetails.value.mobile ?? '';
    whatsAppTextController.text = userDetails.value.whatsAppNumber ?? '';
    dobTextController.text =
        FormatHelper.formatDateOfBirthToIST(userDetails.value.dob);
    genderValue = userDetails.value.gender ?? '';
    addressTextController.text = userDetails.value.address ?? '';
    cityTextController.text = userDetails.value.city ?? '';
    pincodeTextController.text = userDetails.value.pincode ?? '';
    stateTextController.text = userDetails.value.state ?? '';
    countryTextController.text = userDetails.value.country ?? '';
    profilePhotoFile(
        await downloadFileAsPlatformFile(userDetails.value.profilePhoto));
    isProfileLoading(false);
  }

  void loadBankDetails() async {
    isBankLoading(true);
    userDetails(AppStorage.getUserDetails());
    upiIdTextController.text = userDetails.value.upiId ?? '';
    googlePayNumberTextController.text =
        userDetails.value.googlePayNumber ?? '';
    phonePeNumberTextController.text = userDetails.value.phonePeNumber ?? '';
    paytmNumberTextController.text = userDetails.value.payTMNumber ?? '';
    nameAsPerBankAccountTextController.text =
        userDetails.value.nameAsPerBankAccount ?? '';
    bankNameTextController.text = userDetails.value.bankName ?? '';
    accountNumberTextController.text = userDetails.value.accountNumber ?? '';
    ifscCodeTextController.text = userDetails.value.ifscCode ?? '';
    aadhaarCardNumberTextController.text =
        userDetails.value.aadhaarNumber ?? '';
    panCardNumberTextController.text = userDetails.value.panNumber ?? '';
    passportCardNumberTextController.text =
        userDetails.value.passportNumber ?? '';
    drivingLicenseNumberTextController.text =
        userDetails.value.drivingLicenseNumber ?? '';
    aadhaarCardFrontFile(await downloadFileAsPlatformFile(
        userDetails.value.aadhaarCardFrontImage));
    aadhaarCardBackFile(await downloadFileAsPlatformFile(
        userDetails.value.aadhaarCardBackImage));
    panCardFile(
        await downloadFileAsPlatformFile(userDetails.value.panCardFrontImage));
    passportSizePhotoFile(
        await downloadFileAsPlatformFile(userDetails.value.passportPhoto));
    addressProofFile(await downloadFileAsPlatformFile(
        userDetails.value.addressProofDocument));
    dobTextController.text =
        FormatHelper.formatDateOfBirthToIST(userDetails.value.dob);
    selectedStates.value = userDetails.value.bankState ?? '';
    kycAadhaarNumberTextController.text = userDetails.value.aadhaarNumber ?? '';
    isBankLoading(false);
  }

  PlatformFile? convertFile(UserImageDetails? doc) {
    PlatformFile? file = PlatformFile(name: '', size: 0);
    if (doc?.url != null) {
      file = PlatformFile(name: doc?.name ?? 'File', size: 0, path: '-');
    }
    return file;
  }

  Future<PlatformFile?> downloadFileAsPlatformFile(
      UserImageDetails? doc) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        doc?.url ?? '',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final tempDir =
            await Directory.systemTemp.createTemp('downloaded_files');
        final tempFile = File('${tempDir.path}/${doc?.name}');

        await tempFile.writeAsBytes(response.data);

        return PlatformFile(
          name: doc?.name ?? 'File',
          path: tempFile.path,
          size: tempFile.lengthSync(),
        );
      } else {
        print('Failed to download the file: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error downloading the file: $e');
      return null;
    }
  }

  Future<MultipartFile?> convertPlatformFileToMultipartFile(
      PlatformFile? platformFile) async {
    if (platformFile?.path == null) {
      return null;
    } else {
      final file = File(platformFile?.path ?? '');
      return await MultipartFile.fromFile(
        file.path,
        contentType: MediaType.parse(getMediaTypeFromFile(file)),
      );
    }
  }

  String getMediaTypeFromFile(File file) {
    final fileExtension = file.path.split('.').last;
    final mediaType = lookupMimeType(fileExtension);
    print(mediaType);
    return mediaType ?? 'image/$fileExtension';
  }

  Future<bool> isFileSizeLessThan2MB(File file) async {
    try {
      // Get the size of the file in bytes.
      final fileSize = await file.length();

      // Check if the file size is less than 2 MB (2 * 1024 * 1024 bytes).
      if (fileSize <= 2 * 1024 * 1024) {
        return true; // File size is less than or equal to 2 MB.
      } else {
        return false; // File size is larger than 2 MB.
      }
    } catch (e) {
      print('Error checking file size: $e');
      return false;
    }
  }

  void filePicker(KycDocumentType type, {bool removeFile = false}) async {
    PlatformFile? file = PlatformFile(name: '', size: 0);
    bool isValid = false;
    if (!removeFile) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      file = result?.files.first;
      isValid = await isFileSizeLessThan2MB(File(file?.path ?? ''));
    }

    if (!isValid && file?.path != null) {
      SnackbarHelper.showSnackbar('Select image less than 2 MB');
    } else {
      switch (type) {
        case KycDocumentType.aadhaarCardFront:
          aadhaarCardFrontFile(file);
          break;
        case KycDocumentType.aadhaarCardBack:
          aadhaarCardBackFile(file);
          break;
        case KycDocumentType.panCard:
          panCardFile(file);
          break;
        case KycDocumentType.passportPhoto:
          passportSizePhotoFile(file);
          break;
        case KycDocumentType.addressProof:
          addressProofFile(file);
          break;
        case KycDocumentType.profilePhoto:
          profilePhotoFile(file);
          break;
        default:
      }
    }
  }

  Future saveUserProfileDetails() async {
    if (profilePhotoFile.value?.path == null ||
        profilePhotoFile.value!.name.isEmpty) {
      isEditEnabled(false);
      SnackbarHelper.showSnackbar('Select profile picture to continue!');
      return;
    }

    isProfileLoading(true);
    DateTime date = DateFormat('dd-MM-yyyy').parse(dobTextController.text);
    Map<String, dynamic> data = {
      "first_name": firstNameTextController.text,
      "last_name": lastNameTextController.text,
      "email": emailTextController.text,
      "mobile": mobileTextController.text,
      "gender": genderValue,
      "dob": DateFormat('yyyy-MM-dd').format(date),
      "address": addressTextController.text,
      "city": cityTextController.text,
      "pincode": pincodeTextController.text,
      "state": stateTextController.text,
      "country": countryTextController.text,
      'profilePhoto':
          await convertPlatformFileToMultipartFile(profilePhotoFile.value),
      'employeeid': userNameTextController.text,
      'whatsApp_number': whatsAppTextController.text,
    };

    try {
      final RepoResponse<GenericResponse> response =
          await repository.updateUserDetails(data);
      if (response.data != null) {
        if (response.data?.status?.toLowerCase() == "success") {
          final loginDetailsResponse =
              await Get.find<AuthRepository>().loginDetails();
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
      log('Save KYC: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isProfileLoading(false);
  }

  Future saveUserBankDetails() async {
    isBankLoading(true);
    Map<String, dynamic> data = {
      'upiId': upiIdTextController.text,
      'googlePay_number': googlePayNumberTextController.text,
      'phonePe_number': phonePeNumberTextController.text,
      'payTM_number': paytmNumberTextController.text,
      'bankName': bankNameTextController.text,
      'nameAsPerBankAccount': nameAsPerBankAccountTextController.text,
      'accountNumber': accountNumberTextController.text,
      'ifscCode': ifscCodeTextController.text,
      'bankState': selectedStates.value,
    };
    print(data);
    try {
      final RepoResponse<GenericResponse> response =
          await repository.updateUserDetails(data);
      if (response.data != null) {
        await Get.find<AuthController>().getUserDetails(navigate: false);
        loadData();
        // await AppStorage.setUserDetails(
        //   LoginDetailsResponse.fromJson(response.data?.data),
        // );
        log('AppStorage.getUserDetails : ${AppStorage.getUserDetails().toJson()}');
        SnackbarHelper.showSnackbar(response.data?.message);
      } else {
        // SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      // SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isBankLoading(false);
  }

  Future saveUserKYCDetails() async {
    if (aadhaarCardFrontFile.value?.path == null ||
        aadhaarCardBackFile.value?.path == null ||
        panCardFile.value?.path == null) {
      return SnackbarHelper.showSnackbar('Upload Required Document');
    } else if (dobTextController.text.isEmpty) {
      return SnackbarHelper.showSnackbar('Please enter your DOB');
    } else {
      isBankLoading(true);
      DateTime date = DateFormat('dd-MM-yyyy').parse(dobTextController.text);
      Map<String, dynamic> data = {
        'aadhaarNumber': aadhaarCardNumberTextController.text,
        'panNumber': panCardNumberTextController.text,
        'passportNumber': passportCardNumberTextController.text,
        'drivingLicenseNumber': drivingLicenseNumberTextController.text,
        'aadhaarCardFrontImage': await convertPlatformFileToMultipartFile(
            aadhaarCardFrontFile.value),
        'aadhaarCardBackImage':
            await convertPlatformFileToMultipartFile(aadhaarCardBackFile.value),
        'panCardFrontImage':
            await convertPlatformFileToMultipartFile(panCardFile.value),
        'passportPhoto': await convertPlatformFileToMultipartFile(
            passportSizePhotoFile.value),
        'addressProofDocument':
            await convertPlatformFileToMultipartFile(addressProofFile.value),
        "dob": DateFormat('yyyy-MM-dd').format(date),
        "KYCStatus": "Pending Approval"
      };
      try {
        final RepoResponse<GenericResponse> response =
            await repository.updateUserDetails(data);
        if (response.data != null) {
          await Get.find<AuthController>().getUserDetails(navigate: false);
          loadData();
          // await AppStorage.setUserDetails(
          //   LoginDetailsResponse.fromJson(response.data?.data),
          // );
          log('AppStorage.getUserDetails : ${AppStorage.getUserDetails().toJson()}');
          SnackbarHelper.showSnackbar(response.data?.message);
        } else {
          SnackbarHelper.showSnackbar(response.error?.message);
        }
      } catch (e) {
        log('Save: ${e.toString()}');
        SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
      }
      isBankLoading(false);
    }
  }

  Future saveVerifyUserKYCDetailsthroughAPI() async {
    isBankLoading(true);

    Map<String, dynamic> data = {
      'panNumber': kycPanCardNumberTextController.text,
      'bankAccountNumber': kycAccountNumberTextController.text,
      'ifsc': kycIfscCodeTextController.text,
      "aadhaarNumber": kycAadhaarNumberTextController.text,
    };
    try {
      final RepoResponse<GenericResponse> response =
          await repository.updateUserDetails(data);
      if (response.data != null) {
        await Get.find<AuthController>().getUserDetails(navigate: false);
        loadData();
        log('AppStorage.getUserDetails : ${AppStorage.getUserDetails().toJson()}');
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Save: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isBankLoading(false);
  }

  Future verifyKYCGenrateOtpDetails() async {
    isverifyKycLoading(true);
    Map<String, dynamic> data = {
      "aadhaarNumber": kycAadhaarNumberTextController.text,
    };
    try {
      final RepoResponse<VerifyKYCGenrateOTPResponse> response =
          await repository.verifyKYCOtpGenrate(data);
      if (response.data != null) {
        // await Get.find<AuthController>().getUserDetails(navigate: false);
        verifyKYCGenrateOtpDataList(response.data?.data);

        if (response.data?.status == "success") {
          SnackbarHelper.showSnackbar("Aadhaar Otp Sent");
        }
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Save: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isverifyKycLoading(false);
  }

  Future verifyKYCVerifyOtpDetails() async {
    isverifyKycLoading(true);
    Map<String, dynamic> data = {
      'client_id': verifyKYCGenrateOtpDataList.value.clientId ?? '',
      "otp": verifyKYCOtpController.text,
      'panNumber': kycPanCardNumberTextController.text,
      'bankAccountNumber': kycAccountNumberTextController.text,
      'ifsc': kycIfscCodeTextController.text,
    };
    try {
      final RepoResponse<GenericResponse> response =
          await repository.verifyKYCOtpVerify(data);
      if (response.data != null) {
        await Get.find<AuthController>().getUserDetails(navigate: false);
        loadData();
        SnackbarHelper.showSnackbar(response.data?.message);
      } else {
        SnackbarHelper.showSnackbar(response.error?.message);
      }
    } catch (e) {
      log('Save: ${e.toString()}');
      SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
    }
    isverifyKycLoading(false);
  }

  void generateOTP() {
    isOTPGenerated(true);
  }

  void reset() {
    kycAadhaarNumberTextController.clear();
    kycIfscCodeTextController.clear();
    kycAccountNumberTextController.clear();
    kycPanCardNumberTextController.clear();
    isOTPGenerated(false);
    otpTextController.clear();
  }
}
