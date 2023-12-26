import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class ContestStoplossModifyPriceBottomSheet extends GetView<ContestController> {
  final TradingInstrument stopLoss;
  final TransactionType type;
  const ContestStoplossModifyPriceBottomSheet({
    Key? key,
    required this.stopLoss,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Form(
              key: controller.stopLossFormKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.stopLossPriceTextController.clear();
                      controller.stopProfitPriceTextController.clear();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Modify Order',
                          style: Theme.of(context).textTheme.tsMedium16,
                        ),
                        Icon(
                          Icons.cancel,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 24,
                    color: AppColors.grey.shade50.withOpacity(0.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Symbol',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          Text(
                            stopLoss.name ?? '-',
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'LTP (Last Traded Price)',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          Text(
                            FormatHelper.formatNumbers(
                              controller.getInstrumentLastPrice(
                                stopLoss.instrumentToken!,
                                stopLoss.exchangeToken!,
                              ),
                            ),
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Open Lots',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          Text(
                            stopLoss.lotSize.toString(),
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Changes (%)',
                            style: AppStyles.tsGreyMedium12,
                          ),
                          Text(
                            controller.getInstrumentChanges(
                              stopLoss.instrumentToken!,
                              stopLoss.exchangeToken!,
                            ),
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "Stop Loss Quantity",
                        style: AppStyles.tsGreyMedium14,
                      ),
                    ],
                  ),
                  DropdownButtonFormField2<int>(
                    value: controller.selectedContestStopLossQuantity.value,
                    onChanged: (value) =>
                        controller.selectedContestStopLossQuantity(value),
                    isDense: true,
                    items: controller.lotsValueForStopLoss.map((int number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Text(number >= 0
                            ? number.toString()
                            : number.toString()),
                      );
                    }).toList(),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16).copyWith(left: 0),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(.1),
                      hintText: 'Quantity',
                      hintStyle: AppStyles.tsGreyRegular14,
                      errorStyle: AppStyles.tsGreyRegular12.copyWith(
                        color: AppColors.danger.shade700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.lightGreen,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "Stop Profit Quantity",
                        style: AppStyles.tsGreyMedium14,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  DropdownButtonFormField2<int>(
                    value: controller.selectedContestStopProfitQuantity.value,
                    onChanged: (value) =>
                        controller.selectedContestStopProfitQuantity(value),
                    isDense: true,
                    items: controller.lotsValueForStopProfit.map((int number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Text(number >= 0
                            ? number.toString()
                            : number.toString()),
                      );
                    }).toList(),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16).copyWith(left: 0),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(.1),
                      hintText: 'Quantity',
                      hintStyle: AppStyles.tsGreyRegular14,
                      errorStyle: AppStyles.tsGreyRegular12.copyWith(
                        color: AppColors.danger.shade700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.lightGreen,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          hintText: 'Stop Loss Price',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                          ],
                          controller: controller.stopLossPriceTextController,
                          validator: (value) {
                            final stopLossPrice = double.tryParse(
                                controller.stopLossPriceTextController.text);
                            if (stopLossPrice != null) {
                              final isLotSizeNegative =
                                  stopLoss.lotSize.toString().contains('-');
                              final isInvalidPrice = isLotSizeNegative
                                  ? (stopLossPrice <=
                                      controller.getInstrumentLastPrice(
                                        stopLoss.instrumentToken!,
                                        stopLoss.exchangeToken!,
                                      ))
                                  : (stopLossPrice >=
                                      controller.getInstrumentLastPrice(
                                        stopLoss.instrumentToken!,
                                        stopLoss.exchangeToken!,
                                      ));

                              if (isInvalidPrice) {
                                final message = isLotSizeNegative
                                    ? 'StopLoss price should \nbe greater than LTP.'
                                    : 'StopLoss price should \nbe less than LTP.';
                                return message;
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CommonTextField(
                          hintText: 'StopProfit Price',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                          ],
                          controller: controller.stopProfitPriceTextController,
                          validator: (value) {
                            final stopLossPrice = double.tryParse(
                                controller.stopProfitPriceTextController.text);
                            if (stopLossPrice != null) {
                              final isLotSizeNegative =
                                  stopLoss.lotSize.toString().contains('-');
                              final isInvalidPrice = isLotSizeNegative
                                  ? (stopLossPrice >=
                                      controller.getInstrumentLastPrice(
                                        stopLoss.instrumentToken!,
                                        stopLoss.exchangeToken!,
                                      ))
                                  : (stopLossPrice <=
                                      controller.getInstrumentLastPrice(
                                        stopLoss.instrumentToken!,
                                        stopLoss.exchangeToken!,
                                      ));

                              if (isInvalidPrice) {
                                final message = isLotSizeNegative
                                    ? 'StopProfit price should \nbe less than LTP.'
                                    : 'StopProfit price should \nbe greater than LTP.';
                                return message;
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 1,
                          groupValue: 1,
                          label: 'SL/SP-M',
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 8),
                  // Text(
                  //   AppStrings.noteModify,
                  //   style: Theme.of(context).textTheme.tsGreyMedium12,
                  // ),
                  SizedBox(height: 12),
                  CommonFilledButton(
                    label: 'MODIFY',
                    onPressed: () {
                      if (controller.stopLossPriceTextController.text.isEmpty &&
                          controller
                              .stopProfitPriceTextController.text.isEmpty) {
                        SnackbarHelper.showSnackbar(
                            'Please Enter StopLoss or StopProfit Price');
                      } else if (controller.stopLossFormKey.currentState!
                          .validate()) {
                        controller.pendingOrderModify(type, stopLoss);
                      }
                      controller.stopLossPriceTextController.clear();
                      controller.stopProfitPriceTextController.clear();
                    },
                    backgroundColor: AppColors.secondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
