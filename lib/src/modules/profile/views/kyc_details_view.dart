import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class KycDetailsView extends StatefulWidget {
  const KycDetailsView({Key? key}) : super(key: key);

  @override
  State<KycDetailsView> createState() => _KycDetailsViewState();
}

class _KycDetailsViewState extends State<KycDetailsView> {
  late ProfileController controller;

  @override
  void initState() {
    controller = Get.find<ProfileController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // appBar: AppBar(
        //   // title: Text('KYC Details'),
        //   automaticallyImplyLeading: false,
        //   actions: [],
        // ),
        body: Visibility(
          visible: controller.isBankLoadingStatus,
          child: ListViewShimmer(
            itemCount: 10,
            shimmerCard: SmallCardShimmer(),
          ),
          replacement: Container(
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.only(top: 4),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16).copyWith(bottom: 100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Submit and upload your KYC details for StoxHero admin review. Your status will be updated afterwards.",
                          style: Get.isDarkMode
                              ? AppStyles.tsWhiteRegular12
                              : AppStyles.tsBlackRegular12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'KYC Status: ${controller.userDetails.value.kYCStatus}',
                        style: Theme.of(context).textTheme.tsMedium16,
                      ),
                      IconButton(
                        splashRadius: 24,
                        icon: controller.isKYCEditEnabled.value
                            ? Icon(Icons.save)
                            : Icon(Icons.edit),
                        onPressed: controller.isKYCApproved
                            ? null
                            : () {
                                if (controller.isKYCEditEnabled.value) {
                                  controller.saveUserKYCDetails();
                                }
                                controller.isKYCEditEnabled.toggle();
                                FocusScope.of(context).unfocus();
                              },
                        color: AppColors.brandYellow,
                      )
                    ],
                  ),
                  AbsorbPointer(
                    absorbing: !controller.isKYCEditEnabled.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 8),
                        Text(
                          'Aadhaar Card Number',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'Aadhaar Card Number',
                          keyboardType: TextInputType.number,
                          controller:
                              controller.aadhaarCardNumberTextController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                        Text(
                          'Pan Card Number',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'PAN Card Number',
                          controller: controller.panCardNumberTextController,
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                        Text(
                          'Date of Birth',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => controller.showDateRangePicker(context),
                          child: CommonTextField(
                            isDisabled: true,
                            padding: EdgeInsets.zero,
                            controller: controller.dobTextController,
                            hintText: 'Date of Birth',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: AppColors.grey,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your DOB';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 12),
                        CommonImageUpload(
                          label: 'Aadhaar Card Front Image *',
                          file: controller.aadhaarCardFrontFile.value,
                          selectFile: () => controller.filePicker(
                            KycDocumentType.aadhaarCardFront,
                          ),
                          removeFile: () => controller.filePicker(
                            KycDocumentType.aadhaarCardFront,
                            removeFile: true,
                          ),
                        ),
                        SizedBox(height: 12),
                        CommonImageUpload(
                          label: 'Aadhaar Card Back Image *',
                          file: controller.aadhaarCardBackFile.value,
                          selectFile: () => controller.filePicker(
                            KycDocumentType.aadhaarCardBack,
                          ),
                          removeFile: () => controller.filePicker(
                            KycDocumentType.aadhaarCardBack,
                            removeFile: true,
                          ),
                        ),
                        SizedBox(height: 12),
                        CommonImageUpload(
                          label: 'Pan Card Image *',
                          file: controller.panCardFile.value,
                          selectFile: () => controller.filePicker(
                            KycDocumentType.panCard,
                          ),
                          removeFile: () => controller.filePicker(
                            KycDocumentType.panCard,
                            removeFile: true,
                          ),
                        ),
                        SizedBox(height: 12),
                        CommonImageUpload(
                          label: 'Passport Size Image',
                          file: controller.passportSizePhotoFile.value,
                          selectFile: () => controller.filePicker(
                            KycDocumentType.passportPhoto,
                          ),
                          removeFile: () => controller.filePicker(
                            KycDocumentType.passportPhoto,
                            removeFile: true,
                          ),
                        ),
                        SizedBox(height: 12),
                        CommonImageUpload(
                          label: 'Address Proof Image',
                          file: controller.addressProofFile.value,
                          selectFile: () => controller.filePicker(
                            KycDocumentType.addressProof,
                          ),
                          removeFile: () => controller.filePicker(
                            KycDocumentType.addressProof,
                            removeFile: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
