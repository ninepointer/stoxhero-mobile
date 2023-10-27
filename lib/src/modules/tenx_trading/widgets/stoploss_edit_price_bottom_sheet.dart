import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class StoplossEditPriceBottomSheet extends GetView<TenxTradingController> {
  final StopLossPendingOrdersList stopLoss;
  const StoplossEditPriceBottomSheet({
    Key? key,
    required this.stopLoss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ltp = controller.getInstrumentLastPrice(
      stopLoss.instrumentToken ?? 0,
      stopLoss.exchangeInstrumentToken ?? 0,
    );
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
            child: Column(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Price',
                            style: Theme.of(context).textTheme.tsMedium16,
                          ),
                          Icon(
                            Icons.cancel,
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            stopLoss.type ?? '',
                            style: Theme.of(context).textTheme.tsMedium16.copyWith(
                                  color: stopLoss.type == 'StopLoss' ? AppColors.danger : AppColors.success,
                                ),
                          ),
                          Text(
                            stopLoss.buyOrSell ?? '',
                            style: Theme.of(context).textTheme.tsMedium16.copyWith(
                                  color: stopLoss.buyOrSell == 'SELL' ? AppColors.danger : AppColors.success,
                                ),
                          ),
                        ],
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
                    Text(
                      // '',
                      stopLoss.symbol ?? '-',
                      style: AppStyles.tsSecondaryMedium16,
                    ),
                    Text(
                      FormatHelper.formatNumbers(
                        controller.getInstrumentLastPrice(
                          stopLoss.instrumentToken ?? 0,
                          stopLoss.exchangeInstrumentToken ?? 0,
                        ),
                      ),
                      // '',
                      style: AppStyles.tsSecondaryMedium16,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: 'Quantity',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: controller.quanitityTextController,
                      ),
                    ),
                    SizedBox(width: 16),
                    // Expanded(
                    //   child: (stopLoss.type == 'StopLoss')
                    //       ? CommonTextField(
                    //           hintText: 'StopLoss Price',
                    //           inputFormatters: [
                    //             FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    //           ],
                    //           controller: controller.stopLossPriceTextController,
                    //           validator: (value) {
                    //             final stopLossPrice = double.tryParse(controller.stopLossPriceTextController.text);
                    //             if (stopLossPrice != null && stopLossPrice >= ltp) {
                    //               return 'Stop Loss price should \n be less than LTP.';
                    //             }
                    //             return null;
                    //           },
                    //         )
                    //       : (stopLoss.type == 'Sell')
                    //           ? CommonTextField(
                    //               hintText: 'StopLoss Price',
                    //               inputFormatters: [
                    //                 FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    //               ],
                    //               controller: controller.stopLossPriceTextController,
                    //               validator: (value) {
                    //                 final stopLossPrice = double.tryParse(controller.stopLossPriceTextController.text);
                    //                 if (stopLossPrice != null && stopLossPrice <= ltp) {
                    //                   return 'Stop Loss price should \n be less than LTP.';
                    //                 }
                    //                 return null;
                    //               },
                    //             )
                    //           : CommonTextField(
                    //               hintText: 'StopProfit Price',
                    //               inputFormatters: [
                    //                 FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    //               ],
                    //               controller: controller.stopProfitPriceTextController,
                    //               validator: (value) {
                    //                 final stopProfitPrice =
                    //                     double.tryParse(controller.stopProfitPriceTextController.text);
                    //                 if (stopProfitPrice != null && stopProfitPrice >= ltp) {
                    //                   return 'Stop Profit price should \n be less than LTP.';
                    //                 }
                    //                 return null;
                    //               },
                    //             ),
                    Expanded(
                      child: (stopLoss.buyOrSell == 'SELL')
                          ? (stopLoss.type == 'StopLoss')
                              ? CommonTextField(
                                  hintText: 'StopLoss Price',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                                  ],
                                  controller: controller.stopLossPriceTextController,
                                )
                              : CommonTextField(
                                  hintText: 'StopProfit Price',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                                  ],
                                  controller: controller.stopProfitPriceTextController,
                                  validator: (value) {
                                    
                                  },
                                )
                          : CommonTextField(
                              hintText: 'StopProfit Price',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                              ],
                              controller: controller.stopProfitPriceTextController,
                            ),
                    )
                  ],
                ),
                CommonFilledButton(
                  isLoading: controller.isPendingOrderStateLoading.value,
                  label: 'Edit',
                  backgroundColor: AppColors.secondary,
                  onPressed: () {
                    controller.getStopLossEditOrder(stopLoss.id);
                    controller.stopLossPriceTextController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
