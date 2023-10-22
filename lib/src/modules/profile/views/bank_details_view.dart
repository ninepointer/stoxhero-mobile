import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class BankDetailsView extends GetView<ProfileController> {
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
              icon: controller.isKYCEditEnabled.value ? Icon(Icons.save) : Icon(Icons.edit),
              onPressed: controller.userDetails.value.kYCStatus == 'Approved'
                  ? null
                  : () {
                      if (controller.isKYCEditEnabled.value) {
                        controller.saveUserBankDetails();
                      }
                      controller.isKYCEditEnabled.toggle();
                      FocusScope.of(context).unfocus();
                    },
            )
          ],
        ),
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
              child: AbsorbPointer(
                absorbing: !controller.isKYCEditEnabled.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Online Payment',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UPI ID',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          prefixIcon: Icon(Icons.credit_card),
                          hintText: 'UPI ID',
                          controller: controller.upiIdTextController,
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Google Pay Number',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'Google Pay Number',
                          controller: controller.googlePayNumberTextController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PhonePe Number',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'PhonePe Number',
                          controller: controller.phonePeNumberTextController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paytm Number',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'Paytm Number',
                          controller: controller.paytmNumberTextController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                      ],
                    ),
                    Text(
                      'Bank Details',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Name as per Bank Account',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'Your Name as per Bank Account',
                          controller: controller.nameAsPerBankAccountTextController,
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bank Name',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'Bank Name',
                          controller: controller.bankNameTextController,
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Number',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'Account Number',
                          controller: controller.accountNumberTextController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IFSC Code',
                          style: Theme.of(context).textTheme.tsGreyMedium12,
                        ),
                        SizedBox(height: 4),
                        CommonTextField(
                          hintText: 'IFSC Code',
                          controller: controller.ifscCodeTextController,
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                      ],
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
