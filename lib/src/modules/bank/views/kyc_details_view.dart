import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class KycDetailsView extends GetView<BankController> {
  const KycDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('KYC Details'),
          actions: [
            IconButton(
              splashRadius: 24,
              icon: controller.isEditEnabled.value ? Icon(Icons.save) : Icon(Icons.edit),
              onPressed: () {
                if (controller.isEditEnabled.value) controller.saveUserBankDetails();
                controller.isEditEnabled.toggle();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
        body: Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: AbsorbPointer(
                absorbing: !controller.isEditEnabled.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    CommonTextField(
                      hintText: 'Aadhaar Card',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CommonTextField(
                      hintText: 'PAN Card',
                    ),
                    CommonTextField(
                      hintText: 'Passport Number',
                    ),
                    CommonTextField(
                      hintText: 'Driving License',
                    ),
                    CommonFilledButton(
                      label: 'Aadhaar Card',
                      onPressed: () {},
                    ),
                    SizedBox(height: 12),
                    CommonFilledButton(
                      label: 'PAN Card',
                      onPressed: () {},
                    ),
                    SizedBox(height: 12),
                    CommonFilledButton(
                      label: 'Passport',
                      onPressed: () {},
                    ),
                    SizedBox(height: 12),
                    CommonFilledButton(
                      label: 'Driving License',
                      onPressed: () {},
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
