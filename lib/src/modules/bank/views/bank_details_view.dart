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
              onPressed: controller.userDetails.value.kYCStatus == 'Approved'
                  ? null
                  : () {
                      if (controller.isEditEnabled.value) {
                        controller.saveUserBankDetails();
                      }
                      controller.isEditEnabled.toggle();
                      FocusScope.of(context).unfocus();
                    },
            )
          ],
        ),
        body: Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: Container(
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.only(top: 4),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: AbsorbPointer(
                absorbing: !controller.isEditEnabled.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Online Payment',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    SizedBox(height: 12),
                    CommonTextField(
                      prefixIcon: Icon(Icons.credit_card),
                      hintText: 'UPI ID',
                      controller: controller.upiIdTextController,
                    ),
                    CommonTextField(
                      hintText: 'Google Pay Number',
                      controller: controller.googlePayNumberTextController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CommonTextField(
                      hintText: 'PhonePe Number',
                      controller: controller.phonePeNumberTextController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CommonTextField(
                      hintText: 'Paytm Number',
                      controller: controller.paytmNumberTextController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    Text(
                      'Bank Details',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    SizedBox(height: 12),
                    CommonTextField(
                      hintText: 'Your Name as per Bank Account',
                      controller: controller.nameAsPerBankAccountTextController,
                    ),
                    CommonTextField(
                      hintText: 'Bank Name',
                      controller: controller.bankNameTextController,
                    ),
                    CommonTextField(
                      hintText: 'Account Number',
                      controller: controller.accountNumberTextController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CommonTextField(
                      hintText: 'IFSC Code',
                      controller: controller.ifscCodeTextController,
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
