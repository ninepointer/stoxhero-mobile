import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoxhero/src/modules/stocks/controllers/stocks_controller.dart';
import '../../../app/app.dart';

class StockStoplossModifyPriceBottomSheet
    extends GetView<StocksTradingController> {
  final TradingInstrument stopLoss;
  final TransactionType type;
  const StockStoplossModifyPriceBottomSheet({
    Key? key,
    required this.stopLoss,
    required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.stopLossPriceTextController.clear();
    controller.stopProfitPriceTextController.clear();
    controller.stopLossQuantityTextController.clear();
    controller.stopProfitQuantityTextController.clear();
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
                      // controller.stopLossPriceTextController.clear();
                      // controller.stopProfitPriceTextController.clear();
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
                            "${controller.getInstrumentChanges(
                              stopLoss.instrumentToken!,
                              stopLoss.exchangeToken!,
                            )}%",
                            style: AppStyles.tsSecondaryMedium14,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Stop Loss Quantity",
                  //       style: AppStyles.tsGreyMedium14,
                  //     ),
                  //   ],
                  // ),

                  CommonTextField(
                    isDisabled: false,
                    hintText: 'Stop Loss Quantity',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: controller.stopLossQuantityTextController,
                    onChanged: (String? value) {
                      // Update the controller value only if the input is valid
                      if (value != null && value.isNotEmpty) {
                        controller.selectedStopLossQuantity.value =
                            int.parse(value);
                      }
                    },
                  ),

                  SizedBox(height: 8),

                  CommonTextField(
                    isDisabled: false,
                    hintText: 'Stop Profit Quantity',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: controller.stopProfitQuantityTextController,
                    onChanged: (String? value) {
                      // Update the controller value only if the input is valid
                      if (value != null && value.isNotEmpty) {
                        controller.selectedStopProfitQuantity.value =
                            int.parse(value);
                      }
                    },
                  ),

                  SizedBox(height: 4),

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
                                    ? 'Stop Loss price should \n be greater than LTP.'
                                    : 'Stop Loss price should \n be less than LTP.';
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
                                    ? 'Stop Profit price should \n be less than LTP.'
                                    : 'Stop Profit price should \n be greater than LTP.';
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
                      } else if (controller.selectedStopLossQuantity.value ==
                              0 &&
                          controller.selectedStopProfitQuantity.value == 0) {
                        SnackbarHelper.showSnackbar(
                            'Please Select StopLoss or StopProfit Quantity');
                      } else if (controller.stopLossFormKey.currentState!
                          .validate()) {
                        controller.pendingOrderModify(type, stopLoss);
                      }
                      // controller.stopLossPriceTextController.clear();
                      // controller.stopProfitPriceTextController.clear();
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
