import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class StocksStoplossEditPriceBottomSheet
    extends GetView<StocksTradingController> {
  final StocksPendingOrderData stopLoss;
  const StocksStoplossEditPriceBottomSheet({
    Key? key,
    required this.stopLoss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("heeeee ${controller.getInstrumentLastPrice(
      stopLoss.instrumentToken!,
      stopLoss.exchangeInstrumentToken!,
    )}");
    print("stoploss${stopLoss.toJson()}");
    print("line16 ${stopLoss.quantity.toString()}");
    controller.quantityTextController.text = stopLoss.quantity.toString();
    controller.limitPriceTextController.text = stopLoss.price.toString();
    controller.stopProfitPriceTextController.text = stopLoss.price.toString();
    controller.stopLossPriceTextController.text = stopLoss.price.toString();
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
                      // controller.limitPriceTextController.clear();
                    },
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
                              style: Theme.of(context)
                                  .textTheme
                                  .tsMedium16
                                  .copyWith(
                                    color: stopLoss.type == 'StopLoss'
                                        ? AppColors.danger
                                        : AppColors.success,
                                  ),
                            ),
                            Text(
                              stopLoss.buyOrSell ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .tsMedium16
                                  .copyWith(
                                    color: stopLoss.buyOrSell == 'SELL'
                                        ? AppColors.danger
                                        : AppColors.success,
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
                        stopLoss.symbol ?? '-',
                        style: AppStyles.tsSecondaryMedium16,
                      ),
                      Text(
                        FormatHelper.formatNumbers(
                            controller.getInstrumentLastPrice(
                          stopLoss.instrumentToken!,
                          stopLoss.exchangeInstrumentToken!,
                        )),
                        style: AppStyles.tsSecondaryMedium16,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          isDisabled: true,
                          hintText: 'Quantity',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: controller.quantityTextController,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: () {
                          if (stopLoss.buyOrSell == 'SELL') {
                            if (stopLoss.type == 'StopLoss') {
                              return CommonTextField(
                                hintText: 'StopLoss Price',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),
                                ],
                                controller:
                                    controller.stopLossPriceTextController,
                                validator: (value) {
                                  final stopLossPrice = double.tryParse(
                                      controller
                                          .stopLossPriceTextController.text);
                                  if (stopLossPrice != null) {
                                    if (stopLossPrice >
                                        controller.getInstrumentLastPrice(
                                          stopLoss.instrumentToken!,
                                          stopLoss.exchangeInstrumentToken!,
                                        )) {
                                      return 'Stop Loss price should \nbe less than LTP.';
                                    }
                                  }
                                  return null;
                                },
                              );
                            } else if (stopLoss.type == 'StopProfit') {
                              return CommonTextField(
                                hintText: 'StopProfit Price',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),
                                ],
                                controller:
                                    controller.stopProfitPriceTextController,
                                validator: (value) {
                                  final stopProfitPrice = double.tryParse(
                                      controller
                                          .stopProfitPriceTextController.text);
                                  if (stopProfitPrice != null) {
                                    if (stopProfitPrice <
                                        controller.getInstrumentLastPrice(
                                          stopLoss.instrumentToken!,
                                          stopLoss.exchangeInstrumentToken!,
                                        )) {
                                      return 'Stop Profit price should \nbe greater than LTP.';
                                    }
                                  }
                                  return null;
                                },
                              );
                            } else {
                              return CommonTextField(
                                hintText: 'Limit Price',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),
                                ],
                                controller: controller.limitPriceTextController,
                                validator: (value) {
                                  final limitPrice = double.tryParse(
                                      controller.limitPriceTextController.text);
                                  if (limitPrice != null) {
                                    if (limitPrice <
                                        controller.getInstrumentLastPrice(
                                          stopLoss.instrumentToken!,
                                          stopLoss.exchangeInstrumentToken!,
                                        )) {
                                      return 'Price should be \ngreater than LTP.';
                                    }
                                  }
                                  return null;
                                },
                              );
                            }
                          } else if (stopLoss.buyOrSell == 'BUY') {
                            if (stopLoss.type == 'StopLoss') {
                              return CommonTextField(
                                hintText: 'StopLoss Price',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),
                                ],
                                controller:
                                    controller.stopLossPriceTextController,
                                validator: (value) {
                                  final stopLossPrice = double.tryParse(
                                      controller
                                          .stopLossPriceTextController.text);
                                  if (stopLossPrice != null) {
                                    if (stopLossPrice <
                                        controller.getInstrumentLastPrice(
                                          stopLoss.instrumentToken!,
                                          stopLoss.exchangeInstrumentToken!,
                                        )) {
                                      return 'Stop Loss price should \nbe grater than LTP.';
                                    }
                                  }
                                  return null;
                                },
                              );
                            } else if (stopLoss.type == 'StopProfit') {
                              return CommonTextField(
                                hintText: 'StopProfit Price',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),
                                ],
                                controller:
                                    controller.stopProfitPriceTextController,
                                validator: (value) {
                                  final stopProfitPrice = double.tryParse(
                                      controller
                                          .stopProfitPriceTextController.text);
                                  if (stopProfitPrice != null) {
                                    if (stopProfitPrice >=
                                        controller.getInstrumentLastPrice(
                                          stopLoss.instrumentToken!,
                                          stopLoss.exchangeInstrumentToken!,
                                        )) {
                                      return 'Stop Profit price should \nbe less than LTP.';
                                    }
                                  }
                                  return null;
                                },
                              );
                            } else {
                              return CommonTextField(
                                hintText: 'Limit Price',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),
                                ],
                                controller: controller.limitPriceTextController,
                                validator: (value) {
                                  final limitPrice = double.tryParse(
                                      controller.limitPriceTextController.text);
                                  if (limitPrice != null) {
                                    if (limitPrice >=
                                        controller.getInstrumentLastPrice(
                                          stopLoss.instrumentToken!,
                                          stopLoss.exchangeInstrumentToken!,
                                        )) {
                                      return 'Price should be \nless than LTP.';
                                    }
                                  }
                                  return null;
                                },
                              );
                            }
                          } else if (stopLoss.type == 'Limit') {
                            return CommonTextField(
                              hintText: 'Limit Price',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d*')),
                              ],
                              controller: controller.limitPriceTextController,
                              validator: (value) {
                                final limitPrice = double.tryParse(
                                    controller.limitPriceTextController.text);
                                if (limitPrice != null) {
                                  if (limitPrice >=
                                      controller.getInstrumentLastPrice(
                                        stopLoss.instrumentToken!,
                                        stopLoss.exchangeInstrumentToken!,
                                      )) {
                                    return 'Price should be \nless than LTP.';
                                  }
                                }
                                return null;
                              },
                            );
                          } else {
                            return CommonTextField(
                              hintText: 'Limit Price',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d*')),
                              ],
                              controller: controller.limitPriceTextController,
                              validator: (value) {
                                final limitPrice = double.tryParse(
                                    controller.limitPriceTextController.text);
                                if (limitPrice != null) {
                                  if (limitPrice <=
                                      controller.getInstrumentLastPrice(
                                        stopLoss.instrumentToken!,
                                        stopLoss.exchangeInstrumentToken!,
                                      )) {
                                    return 'Price should be \ngreater than LTP.';
                                  }
                                }
                                return null;
                              },
                            );
                          }
                        }(),
                      ),
                    ],
                  ),
                  CommonFilledButton(
                    isLoading: controller.isPendingOrderStateLoading.value,
                    label: 'Edit',
                    backgroundColor: AppColors.secondary,
                    onPressed: () {
                      if (stopLoss.type == 'StopLoss' ||
                          stopLoss.type == 'StopProfit') {
                        if (controller
                                .stopLossPriceTextController.text.isEmpty &&
                            controller
                                .stopProfitPriceTextController.text.isEmpty) {
                          SnackbarHelper.showSnackbar(
                              'Please Enter StopLoss or StopProfit Price');
                        } else {
                          controller.getStopLossEditOrder(
                            stopLoss.sId,
                            stopLoss.type,
                          );
                        }
                      } else if (controller
                          .limitPriceTextController.text.isEmpty) {
                        SnackbarHelper.showSnackbar('Please Enter Price');
                      } else if (controller.stopLossFormKey.currentState!
                          .validate()) {
                        controller.getStopLossEditOrder(
                          stopLoss.sId,
                          stopLoss.type,
                        );
                      }
                      // controller.stopLossPriceTextController.clear();
                      // controller.stopProfitPriceTextController.clear();
                      // controller.limitPriceTextController.clear();
                    },
                  ),
                  SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
