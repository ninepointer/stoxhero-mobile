// import 'dart:developer';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide MultipartFile;
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';

// import '../../../base/base_controller.dart';
// import '../../../core/core.dart';
// import '../../../data/data.dart';

// // enum KycDocumentType {
// //   aadhaarCardFront,
// //   aadhaarCardBack,
// //   panCard,
// //   passportPhoto,
// //   addressProof,
// //   profilePhoto,
// // }

// class BankBinding implements Bindings {
//   @override
//   void dependencies() => Get.put(BankController());
// }

// class BankController extends BaseController<ProfileRepository> {
//   final userDetails = LoginDetailsResponse().obs;
//   final isLoading = false.obs;
//   bool get isLoadingStatus => isLoading.value;
//   final isEditEnabled = false.obs;
//   File? image;

//   final upiIdTextController = TextEditingController();
//   final googlePayNumberTextController = TextEditingController();
//   final phonePeNumberTextController = TextEditingController();
//   final paytmNumberTextController = TextEditingController();

//   final nameAsPerBankAccountTextController = TextEditingController();
//   final bankNameTextController = TextEditingController();
//   final accountNumberTextController = TextEditingController();
//   final ifscCodeTextController = TextEditingController();

//   final aadhaarCardNumberTextController = TextEditingController();
//   final panCardNumberTextController = TextEditingController();
//   final drivingLicenseNumberTextController = TextEditingController();
//   final passportCardNumberTextController = TextEditingController();

//   final Rx<PlatformFile?> aadhaarCardFrontFile = PlatformFile(name: '', size: 0).obs;
//   final Rx<PlatformFile?> aadhaarCardBackFile = PlatformFile(name: '', size: 0).obs;
//   final Rx<PlatformFile?> panCardFile = PlatformFile(name: '', size: 0).obs;
//   final Rx<PlatformFile?> passportSizePhotoFile = PlatformFile(name: '', size: 0).obs;
//   final Rx<PlatformFile?> addressProofFile = PlatformFile(name: '', size: 0).obs;

//   void loadData() {
//     loadBankDetails();
//   }

//   void loadBankDetails() async {
//     isLoading(true);
//     userDetails(AppStorage.getUserDetails());
//     upiIdTextController.text = userDetails.value.upiId ?? '';
//     googlePayNumberTextController.text = userDetails.value.googlePayNumber ?? '';
//     phonePeNumberTextController.text = userDetails.value.phonePeNumber ?? '';
//     paytmNumberTextController.text = userDetails.value.payTMNumber ?? '';
//     nameAsPerBankAccountTextController.text = userDetails.value.nameAsPerBankAccount ?? '';
//     bankNameTextController.text = userDetails.value.bankName ?? '';
//     accountNumberTextController.text = userDetails.value.accountNumber ?? '';
//     ifscCodeTextController.text = userDetails.value.ifscCode ?? '';
//     aadhaarCardNumberTextController.text = userDetails.value.aadhaarNumber ?? '';
//     panCardNumberTextController.text = userDetails.value.panNumber ?? '';
//     passportCardNumberTextController.text = userDetails.value.passportNumber ?? '';
//     drivingLicenseNumberTextController.text = userDetails.value.drivingLicenseNumber ?? '';
//     aadhaarCardFrontFile(await downloadFileAsPlatformFile(userDetails.value.aadhaarCardFrontImage));
//     aadhaarCardBackFile(await downloadFileAsPlatformFile(userDetails.value.aadhaarCardBackImage));
//     panCardFile(await downloadFileAsPlatformFile(userDetails.value.panCardFrontImage));
//     passportSizePhotoFile(await downloadFileAsPlatformFile(userDetails.value.passportPhoto));
//     addressProofFile(await downloadFileAsPlatformFile(userDetails.value.addressProofDocument));
//     isLoading(false);
//   }

//   PlatformFile? convertFile(UserImageDetails? doc) {
//     PlatformFile? file = PlatformFile(name: '', size: 0);
//     if (doc?.url != null) {
//       file = PlatformFile(name: doc?.name ?? 'File', size: 0, path: '-');
//     }
//     return file;
//   }

//   Future<PlatformFile?> downloadFileAsPlatformFile(UserImageDetails? doc) async {
//     try {
//       final dio = Dio();
//       final response = await dio.get(
//         doc?.url ?? '',
//         options: Options(responseType: ResponseType.bytes),
//       );

//       print(response);

//       if (response.statusCode == 200) {
//         final tempDir = await Directory.systemTemp.createTemp('downloaded_files');
//         final tempFile = File('${tempDir.path}/${doc?.name}');

//         await tempFile.writeAsBytes(response.data);

//         return PlatformFile(
//           name: doc?.name ?? 'File',
//           path: tempFile.path,
//           size: tempFile.lengthSync(),
//         );
//       } else {
//         print('Failed to download the file: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error downloading the file: $e');
//       return null;
//     }
//   }

//   Future<MultipartFile?> convertPlatformFileToMultipartFile(PlatformFile? platformFile) async {
//     if (platformFile?.path == null) {
//       return null;
//     } else {
//       final file = File(platformFile?.path ?? '');
//       return await MultipartFile.fromFile(
//         file.path,
//         contentType: MediaType.parse(getMediaTypeFromFile(file)),
//       );
//     }
//   }

//   String getMediaTypeFromFile(File file) {
//     final fileExtension = file.path.split('.').last;
//     final mediaType = lookupMimeType(fileExtension);
//     return mediaType ?? 'image/jpeg';
//   }

//   Future<bool> isFileSizeLessThan2MB(File file) async {
//     try {
//       // Get the size of the file in bytes.
//       final fileSize = await file.length();

//       // Check if the file size is less than 2 MB (2 * 1024 * 1024 bytes).
//       if (fileSize <= 2 * 1024 * 1024) {
//         return true; // File size is less than or equal to 2 MB.
//       } else {
//         return false; // File size is larger than 2 MB.
//       }
//     } catch (e) {
//       print('Error checking file size: $e');
//       return false;
//     }
//   }

//   void filePicker(KycDocumentType type, {bool removeFile = false}) async {
//     PlatformFile? file = PlatformFile(name: '', size: 0);
//     if (!removeFile) {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.image,
//       );
//       file = result?.files.first;
//     }

//     print(file?.path ?? '');
//     bool isValid = await isFileSizeLessThan2MB(File(file?.path ?? ''));

//     if (!isValid && file?.path != null) {
//       SnackbarHelper.showSnackbar('Select image less than 2 MB');
//     } else {
//       switch (type) {
//         case KycDocumentType.aadhaarCardFront:
//           aadhaarCardFrontFile(file);
//           break;
//         case KycDocumentType.aadhaarCardBack:
//           aadhaarCardBackFile(file);
//           break;
//         case KycDocumentType.panCard:
//           panCardFile(file);
//           break;
//         case KycDocumentType.passportPhoto:
//           passportSizePhotoFile(file);
//           break;
//         case KycDocumentType.addressProof:
//           addressProofFile(file);
//           break;
//         default:
//       }
//     }
//   }

//   Future saveUserBankDetails() async {
//     isLoading(true);
//     Map<String, dynamic> data = {
//       'upiId': upiIdTextController.text,
//       'googlePay_number': googlePayNumberTextController.text,
//       'phonePe_number': phonePeNumberTextController.text,
//       'payTM_number': paytmNumberTextController.text,
//       'bankName': bankNameTextController.text,
//       'nameAsPerBankAccount': nameAsPerBankAccountTextController.text,
//       'accountNumber': accountNumberTextController.text,
//       'ifscCode': ifscCodeTextController.text,
//     };
//     try {
//       final RepoResponse<GenericResponse> response = await repository.updateUserDetails(data);
//       if (response.data != null) {
//         await AppStorage.setUserDetails(
//           LoginDetailsResponse.fromJson(response.data?.data),
//         );
//         log('AppStorage.getUserDetails : ${AppStorage.getUserDetails().toJson()}');
//         SnackbarHelper.showSnackbar(response.data?.message);
//       } else {
//         SnackbarHelper.showSnackbar(response.error?.message);
//       }
//     } catch (e) {
//       log('Save: ${e.toString()}');
//       SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
//     }

//     isLoading(false);
//   }

//   Future saveUserKYCDetails() async {
//     if (aadhaarCardFrontFile.value?.path == null ||
//         aadhaarCardBackFile.value?.path == null ||
//         panCardFile.value?.path == null) {
//       return SnackbarHelper.showSnackbar('Upload Required Document');
//     } else {
//       isLoading(true);
//       Map<String, dynamic> data = {
//         'aadhaarNumber': aadhaarCardNumberTextController.text,
//         'panNumber': panCardNumberTextController.text,
//         'passportNumber': passportCardNumberTextController.text,
//         'drivingLicenseNumber': drivingLicenseNumberTextController.text,
//         'aadhaarCardFrontImage': await convertPlatformFileToMultipartFile(aadhaarCardFrontFile.value),
//         'aadhaarCardBackImage': await convertPlatformFileToMultipartFile(aadhaarCardBackFile.value),
//         'panCardFrontImage': await convertPlatformFileToMultipartFile(panCardFile.value),
//         'passportPhoto': await convertPlatformFileToMultipartFile(passportSizePhotoFile.value),
//         'addressProofDocument': await convertPlatformFileToMultipartFile(addressProofFile.value),
//       };
//       try {
//         final RepoResponse<GenericResponse> response = await repository.updateUserDetails(data);
//         if (response.data != null) {
//           await AppStorage.setUserDetails(
//             LoginDetailsResponse.fromJson(response.data?.data),
//           );
//           log('AppStorage.getUserDetails : ${AppStorage.getUserDetails().toJson()}');
//           SnackbarHelper.showSnackbar(response.data?.message);
//         } else {
//           SnackbarHelper.showSnackbar(response.error?.message);
//         }
//       } catch (e) {
//         log('Save: ${e.toString()}');
//         SnackbarHelper.showSnackbar(ErrorMessages.somethingWentWrong);
//       }

//       isLoading(false);
//     }
//   }
// }
