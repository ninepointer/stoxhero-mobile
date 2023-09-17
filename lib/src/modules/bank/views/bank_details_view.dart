import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class BankDetailsView extends GetView<BankController> {
  const BankDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Bank Details'),
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
                    Text(
                      'Online Payment',
                      textAlign: TextAlign.start,
                      style: AppStyles.tsGreyMedium16,
                    ),
                    SizedBox(height: 12),
                    CommonTextField(
                      prefixIcon: Icon(Icons.credit_card),
                      hintText: 'UPI ID',
                    ),
                    CommonTextField(
                      hintText: 'Google Pay Number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CommonTextField(
                      hintText: 'PhonePe Number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CommonTextField(
                      hintText: 'Paytm Number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    Text(
                      'Bank Details',
                      textAlign: TextAlign.start,
                      style: AppStyles.tsGreyMedium16,
                    ),
                    SizedBox(height: 12),
                    CommonTextField(
                      hintText: 'Your Name as per Bank Account',
                    ),
                    CommonTextField(
                      hintText: 'Bank Name',
                    ),
                    CommonTextField(
                      hintText: 'Account Number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CommonTextField(
                      hintText: 'IFSC Code',
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
