import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class KYCViewSelector extends StatefulWidget {
  @override
  _KYCViewSelectorState createState() => _KYCViewSelectorState();
}

class _KYCViewSelectorState extends State<KYCViewSelector> {
  late ProfileController controller;

  @override
  void initState() {
    controller = Get.find<ProfileController>();
    VerifyKYCGenrateOTPData emptyData = VerifyKYCGenrateOTPData();
    controller.verifyKYCGenrateOtpDataList(emptyData);
    controller.reset();
    controller.isVerifyButtonVisible.value = false;
    controller.otpTextController.clear();
    controller.isOTPGenerated(false);
    controller.saveVerifyUserKYCDetailsthroughAPI();

    super.initState();
  }

  int selectedRadioButton = 1;

  @override
  Widget build(BuildContext context) {
    String? kycStatus = controller.userDetails.value.kYCStatus;

    if (kycStatus == "Approved") {
      // If KYC is approved, directly show KycVarificationView
      return Scaffold(
        appBar: AppBar(
          title: Text('KYC Verification'),
        ),
        body: KycVarificationView(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('KYC Verification'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Select KYC Verifaction Method",
                      style: Get.isDarkMode
                          ? AppStyles.tsWhiteMedium16
                          : AppStyles.tsBlackMedium16,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: selectedRadioButton,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton = value as int;
                        });
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Automatic Instant KYC',
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: selectedRadioButton,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton = value as int;
                        });
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Admin Approved KYC',
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: selectedRadioButton == 1
                ? KycVarificationView()
                : KycDetailsView(),
          ),
        ],
      ),
    );
  }
}
