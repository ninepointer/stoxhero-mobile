import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class KycVarificationView extends StatefulWidget {
  const KycVarificationView({Key? key}) : super(key: key);

  @override
  State<KycVarificationView> createState() => _KycVarificationViewState();
}

class _KycVarificationViewState extends State<KycVarificationView> {
  late ProfileController controller;

  @override
  void initState() {
    controller = Get.find<ProfileController>();
    controller.isVerifyButtonVisible.value = false;
    controller.otpTextController.clear();
    controller.isOTPGenerated(false);
    VerifyKYCGenrateOTPData emptyData = VerifyKYCGenrateOTPData();
    controller.verifyKYCGenrateOtpDataList(emptyData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('KYC Verification'),
        ),
        body: Visibility(
          visible: controller.isverifyKycLoadingStatus,
          child: ListViewShimmer(
            itemCount: 10,
            shimmerCard: SmallCardShimmer(),
          ),
          replacement: Container(
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.only(top: 4),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16).copyWith(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'KYC Status:',
                        style: Theme.of(context).textTheme.tsMedium16,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${controller.userDetails.value.kYCStatus}',
                        style: Theme.of(context).textTheme.tsMedium16.copyWith(
                            color: controller.userDetails.value.kYCStatus ==
                                    "Not Initiated"
                                ? AppColors.danger
                                : AppColors.success),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Aadhaar Card Number',
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  SizedBox(height: 8),
                  CommonTextField(
                    hintText: 'Aadhaar Card Number',
                    keyboardType: TextInputType.number,
                    controller: controller.kycAadhaarNumberTextController,
                    enabled:
                        controller.userDetails.value.kYCStatus != 'Approved',
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
                  SizedBox(height: 8),
                  CommonTextField(
                    hintText: 'PAN Card Number',
                    controller: controller.kycPanCardNumberTextController,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    enabled:
                        controller.userDetails.value.kYCStatus != 'Approved',
                    padding: EdgeInsets.only(bottom: 8),
                  ),
                  Text(
                    'Bank Account Number',
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  SizedBox(height: 8),
                  CommonTextField(
                    hintText: 'Bank Account Number',
                    controller: controller.kycAccountNumberTextController,
                    enabled:
                        controller.userDetails.value.kYCStatus != 'Approved',
                    padding: EdgeInsets.only(bottom: 8),
                  ),
                  Text(
                    'Ifsc Code',
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  SizedBox(height: 8),
                  CommonTextField(
                    hintText: 'Ifsc Code',
                    controller: controller.kycIfscCodeTextController,
                    enabled:
                        controller.userDetails.value.kYCStatus != 'Approved',
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    padding: EdgeInsets.only(bottom: 8),
                  ),
                  SizedBox(height: 12),
                  (controller.verifyKYCGenrateOtpDataList.value.status ==
                              "generate_otp_success" &&
                          controller.userDetails.value.kYCStatus != "Approved")
                      ? CommonTextField(
                          hintText: 'Enter Your Otp ',
                          controller: controller.verifyKYCOtpController,
                          padding: EdgeInsets.only(bottom: 8),
                        )
                      : Container(),
                  SizedBox(height: 12),
                  if (controller.userDetails.value.kYCStatus != "Approved")
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              controller.reset();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            child: Text("Reset"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (controller
                                .verifyKYCGenrateOtpDataList.value.status !=
                            "generate_otp_success")
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                controller.verifyKYCGenrateOtpDetails();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green)),
                              child: Text("Generate OTP"),
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (controller
                                .verifyKYCGenrateOtpDataList.value.status ==
                            "generate_otp_success")
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                controller.verifyKYCVerifyOtpDetails();
                                controller.saveVerifyUserKYCDetailsthroughAPI();
                                controller.otpTextController.clear();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              child: Text("Verify OTP"),
                            ),
                          ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
