// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../app/app.dart';

// class KycDetailsView extends StatefulWidget {
//   const KycDetailsView({Key? key}) : super(key: key);

//   @override
//   State<KycDetailsView> createState() => _KycDetailsViewState();
// }

// class _KycDetailsViewState extends State<KycDetailsView> {
//   late BankController controller;

//   @override
//   void initState() {
//     controller = Get.find<BankController>();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         appBar: AppBar(
//           title: Text('KYC Details'),
//           actions: [
//             IconButton(
//               splashRadius: 24,
//               icon: controller.isEditEnabled.value ? Icon(Icons.save) : Icon(Icons.edit),
//               onPressed: controller.userDetails.value.kYCStatus == 'Approved'
//                   ? null
//                   : () {
//                       if (controller.isEditEnabled.value) {
//                         controller.saveUserKYCDetails();
//                       }
//                       controller.isEditEnabled.toggle();
//                       FocusScope.of(context).unfocus();
//                     },
//             )
//           ],
//         ),
//         body: Visibility(
//           visible: !controller.isLoadingStatus,
//           replacement: CommonLoader(),
//           child: Container(
//             color: Theme.of(context).cardColor,
//             margin: EdgeInsets.only(top: 4),
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(16).copyWith(bottom: 100),
//               child: AbsorbPointer(
//                 absorbing: !controller.isEditEnabled.value,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'KYC Status: ${controller.userDetails.value.kYCStatus}',
//                       style: Theme.of(context).textTheme.tsMedium16,
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Aadhaar Card Number',
//                       style: Theme.of(context).textTheme.tsGreyMedium12,
//                     ),
//                     SizedBox(height: 4),
//                     CommonTextField(
//                       hintText: 'Aadhaar Card Number',
//                       keyboardType: TextInputType.number,
//                       controller: controller.aadhaarCardNumberTextController,
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(12),
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       padding: EdgeInsets.only(bottom: 8),
//                     ),
//                     Text(
//                       'Pan Card Number',
//                       style: Theme.of(context).textTheme.tsGreyMedium12,
//                     ),
//                     SizedBox(height: 4),
//                     CommonTextField(
//                       hintText: 'PAN Card Number',
//                       controller: controller.panCardNumberTextController,
//                       padding: EdgeInsets.only(bottom: 8),
//                     ),
//                     Text(
//                       'Passport Number',
//                       style: Theme.of(context).textTheme.tsGreyMedium12,
//                     ),
//                     SizedBox(height: 4),
//                     CommonTextField(
//                       hintText: 'Passport Number',
//                       controller: controller.passportCardNumberTextController,
//                       padding: EdgeInsets.only(bottom: 8),
//                     ),
//                     Text(
//                       'Driving License Number',
//                       style: Theme.of(context).textTheme.tsGreyMedium12,
//                     ),
//                     SizedBox(height: 4),
//                     CommonTextField(
//                       hintText: 'Driving License Number',
//                       controller: controller.drivingLicenseNumberTextController,
//                     ),
//                     buildImage(
//                       label: 'Aadhaar Card Front Image *',
//                       file: controller.aadhaarCardFrontFile.value,
//                       selectFile: () => controller.filePicker(
//                         KycDocumentType.aadhaarCardFront,
//                       ),
//                       removeFile: () => controller.filePicker(
//                         KycDocumentType.aadhaarCardFront,
//                         removeFile: true,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     buildImage(
//                       label: 'Aadhaar Card Back Image *',
//                       file: controller.aadhaarCardBackFile.value,
//                       selectFile: () => controller.filePicker(
//                         KycDocumentType.aadhaarCardBack,
//                       ),
//                       removeFile: () => controller.filePicker(
//                         KycDocumentType.aadhaarCardBack,
//                         removeFile: true,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     buildImage(
//                       label: 'Pan Card Image *',
//                       file: controller.panCardFile.value,
//                       selectFile: () => controller.filePicker(
//                         KycDocumentType.panCard,
//                       ),
//                       removeFile: () => controller.filePicker(
//                         KycDocumentType.panCard,
//                         removeFile: true,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     buildImage(
//                       label: 'Passport Size Image',
//                       file: controller.passportSizePhotoFile.value,
//                       selectFile: () => controller.filePicker(
//                         KycDocumentType.passportPhoto,
//                       ),
//                       removeFile: () => controller.filePicker(
//                         KycDocumentType.passportPhoto,
//                         removeFile: true,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     buildImage(
//                       label: 'Address Proof Image',
//                       file: controller.addressProofFile.value,
//                       selectFile: () => controller.filePicker(
//                         KycDocumentType.addressProof,
//                       ),
//                       removeFile: () => controller.filePicker(
//                         KycDocumentType.addressProof,
//                         removeFile: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildImage({
//     required String label,
//     VoidCallback? selectFile,
//     VoidCallback? removeFile,
//     PlatformFile? file,
//   }) {
//     bool hasFile = (file?.path != null);
//     return GestureDetector(
//       onTap: selectFile,
//       child: CommonCard(
//         margin: EdgeInsets.zero,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: hasFile ? AppColors.success.withOpacity(.25) : AppColors.grey.withOpacity(.25),
//                 ),
//                 child: Icon(
//                   hasFile ? Icons.verified_rounded : Icons.description_rounded,
//                   size: 20,
//                   color: hasFile ? AppColors.success : AppColors.grey,
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       label,
//                       style: Theme.of(context).textTheme.tsRegular16,
//                     ),
//                     if (hasFile) ...[
//                       SizedBox(height: 4),
//                       Text(
//                         file?.name ?? '',
//                         style: AppStyles.tsGreyRegular14,
//                       ),
//                     ]
//                   ],
//                 ),
//               ),
//               if (hasFile)
//                 IconButton(
//                   icon: Icon(Icons.close),
//                   onPressed: removeFile,
//                   splashRadius: 24,
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
