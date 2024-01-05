import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class CollegeContestTransactionBottomSheet
    extends GetView<CollegeContestController> {
  final TradingInstrument tradingInstrument;
  final TransactionType type;
  final dynamic marginRequired;
  const CollegeContestTransactionBottomSheet({
    super.key,
    required this.type,
    required this.tradingInstrument,
    required this.marginRequired,
  });

  @override
  Widget build(BuildContext context) {
    controller.selectedGroupValue.value = 2;
    controller.selectedType.value = 'MARKET';
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
                      controller.selectedGroupValue.value = 2;
                      controller.stopLossPriceTextController.clear();
                      controller.stopProfitPriceTextController.clear();
                      controller.limitPriceTextController.clear();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Regular',
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
                      Text(
                        tradingInstrument.name ?? '-',
                        style: AppStyles.tsSecondaryMedium16,
                      ),
                      Text(
                        type == TransactionType.buy
                            ? FormatHelper.formatNumbers(
                                controller.getInstrumentLastPrice(
                                  tradingInstrument.instrumentToken!,
                                  tradingInstrument.exchangeToken!,
                                ),
                              )
                            : type == TransactionType.sell
                                ? FormatHelper.formatNumbers(
                                    controller.getInstrumentLastPrice(
                                      tradingInstrument.instrumentToken!,
                                      tradingInstrument.exchangeToken!,
                                    ),
                                  )
                                : tradingInstrument.lotSize.toString(),
                        style: AppStyles.tsSecondaryMedium16,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 2,
                          groupValue: 2,
                          label: 'Interaday (MIS)',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 1,
                          groupValue: 2,
                          label: 'Overnight (NRML)',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField2<int>(
                    value: controller.selectedQuantity.value,
                    onChanged: (value) {
                      controller.selectedQuantity(value?.abs());
                      controller
                          .selectedStringQuantity(value?.abs().toString());

                      controller.getMarginRequired(type, tradingInstrument);
                    },
                    isDense: true,
                    items: controller.lotsValueList.map((int number) {
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
                          color: AppColors.primary,
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
                  if (controller.selectedGroupValue.value == 1) ...[
                    SizedBox(height: 8),
                    CommonTextField(
                      padding: EdgeInsets.zero,
                      hintText: 'Limit Price',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d*')),
                      ],
                      controller: controller.limitPriceTextController,
                      onChanged: (value) =>
                          controller.getMarginRequired(type, tradingInstrument),
                      validator: (value) {
                        final limitPrice = double.tryParse(
                            controller.limitPriceTextController.text);
                        if (limitPrice != null) {
                          if (type == TransactionType.buy) {
                            if (limitPrice >=
                                controller.getInstrumentLastPrice(
                                  tradingInstrument.instrumentToken!,
                                  tradingInstrument.exchangeToken!,
                                )) {
                              return 'Price should be less than LTP.';
                            }
                          } else if (type == TransactionType.sell) {
                            if (limitPrice <=
                                controller.getInstrumentLastPrice(
                                  tradingInstrument.instrumentToken!,
                                  tradingInstrument.exchangeToken!,
                                )) {
                              return 'Price should be greater than LTP.';
                            }
                          }
                        }
                        return null;
                      },
                    ),
                  ],
                  if (controller.selectedGroupValue.value == 3) ...[
                    SizedBox(height: 8),
                    if (type != TransactionType.exit)
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              padding: EdgeInsets.zero,
                              isDisabled: controller.handleTextField(
                                    type,
                                    tradingInstrument.lotSize ?? 0,
                                    controller.selectedQuantity.value,
                                  ) ||
                                  controller.selectedGroupValue.value == 2,
                              hintText: 'StopLoss Price',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d*')),
                              ],
                              controller:
                                  controller.stopLossPriceTextController,
                              validator: (value) {
                                final stopLossPrice = double.tryParse(controller
                                    .stopLossPriceTextController.text);
                                if (stopLossPrice != null) {
                                  if (type == TransactionType.buy) {
                                    if (stopLossPrice >=
                                        controller.getInstrumentLastPrice(
                                          tradingInstrument.instrumentToken!,
                                          tradingInstrument.exchangeToken!,
                                        )) {
                                      return 'StopLoss price should \nbe less than LTP.';
                                    }
                                  } else if (type == TransactionType.sell) {
                                    if (stopLossPrice <=
                                        controller.getInstrumentLastPrice(
                                          tradingInstrument.instrumentToken!,
                                          tradingInstrument.exchangeToken!,
                                        )) {
                                      return 'StopLoss price should \nbe greater than LTP.';
                                    }
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: CommonTextField(
                              padding: EdgeInsets.zero,
                              isDisabled: controller.handleTextField(
                                    type,
                                    tradingInstrument.lotSize ?? 0,
                                    controller.selectedQuantity.value,
                                  ) ||
                                  controller.selectedGroupValue.value == 2,
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
                                  if (type == TransactionType.buy) {
                                    if (stopProfitPrice <=
                                        controller.getInstrumentLastPrice(
                                          tradingInstrument.instrumentToken!,
                                          tradingInstrument.exchangeToken!,
                                        )) {
                                      return 'StopProfit price should \nbe greater than LTP.';
                                    }
                                  } else if (type == TransactionType.sell) {
                                    if (stopProfitPrice >=
                                        controller.getInstrumentLastPrice(
                                          tradingInstrument.instrumentToken!,
                                          tradingInstrument.exchangeToken!,
                                        )) {
                                      return 'StopProfit price should \nbe less than LTP.';
                                    }
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 2,
                          groupValue: controller.selectedGroupValue.value,
                          label: 'MARKET',
                          onChanged: (int value) {
                            controller.handleRadioValueChanged(value, "MARKET");
                            controller.getMarginRequired(
                                type, tradingInstrument);
                            controller.stopLossPriceTextController.clear();
                            controller.stopProfitPriceTextController.clear();
                            controller.limitPriceTextController.clear();
                          },
                        ),
                      ),
                      if (type != TransactionType.exit) ...[
                        SizedBox(width: 8),
                        Expanded(
                          child: CommonRadioButtonTile(
                            value: 1,
                            groupValue: controller.selectedGroupValue.value,
                            label: 'LIMIT',
                            onChanged: (int value) {
                              controller.handleRadioValueChanged(
                                  value, "LIMIT");
                              controller.getMarginRequired(
                                  type, tradingInstrument);
                              controller.stopLossPriceTextController.clear();
                              controller.stopProfitPriceTextController.clear();
                              controller.limitPriceTextController.clear();
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: CommonRadioButtonTile(
                            value: 3,
                            groupValue: controller.selectedGroupValue.value,
                            label: 'SL/SP-M',
                            onChanged: (int value) {
                              controller.handleRadioValueChanged(
                                  value, "SL/SP-M");
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 3,
                          groupValue: 3,
                          label: 'Day',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 4,
                          groupValue: 3,
                          label: 'Immediate',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 1,
                          groupValue: 3,
                          label: 'Minutes',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  //svdkg\
                  //dsbdssdfb
                  //dsbdb
                  CommonCard(
                    margin: EdgeInsets.only(),
                    padding: EdgeInsets.zero.copyWith(left: 12, right: 12),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Available Margin',
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                          Visibility(
                            visible: controller.isMarginStateLoadingStatus,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                child: CommonLoader(),
                                height: 24,
                                width: 24,
                              ),
                            ),
                            replacement: Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        top: 24,
                                        bottom: 24)),
                                Text(
                                  FormatHelper.formatNumbers(
                                    controller
                                        .calculateMargin()
                                        .round()
                                        .toString(),
                                  ),
                                  style: Theme.of(context).textTheme.tsMedium14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //sddhgvd
                  //egdsgoihg
                  SizedBox(height: 8),
                  CommonCard(
                    margin: EdgeInsets.only(),
                    padding: EdgeInsets.zero.copyWith(left: 12),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Virtual Margin Required',
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                          Visibility(
                            visible: controller.isMarginStateLoadingStatus,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                child: CommonLoader(),
                                height: 24,
                                width: 24,
                              ),
                            ),
                            replacement: Row(
                              children: [
                                Text(
                                  FormatHelper.formatNumbers(
                                      controller.marginRequired.value.margin),
                                  style: Theme.of(context).textTheme.tsMedium14,
                                ),
                                IconButton(
                                  onPressed: () => controller.getMarginRequired(
                                      type, tradingInstrument),
                                  icon: Icon(Icons.refresh, size: 18),
                                  splashRadius: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CommonFilledButton(
                    isLoading: controller.isTradingOrderSheetLoading.value,
                    backgroundColor: type == TransactionType.exit
                        ? AppColors.warning
                        : tradingInstrument.lotSize.toString().contains('-')
                            ? type == TransactionType.buy
                                ? AppColors.danger
                                : AppColors.success
                            : type == TransactionType.buy
                                ? AppColors.success
                                : AppColors.danger,
                    margin: EdgeInsets.only(top: 12, bottom: 18),
                    label: type == TransactionType.exit
                        ? 'Exit'
                        : tradingInstrument.lotSize.toString().contains('-')
                            ? type == TransactionType.buy
                                ? 'SELL'
                                : 'BUY'
                            : type == TransactionType.buy
                                ? 'BUY'
                                : 'SELL',
                    onPressed: () {
                      if (controller.selectedGroupValue.value == 3 &&
                          controller.stopLossPriceTextController.text.isEmpty &&
                          controller
                              .stopProfitPriceTextController.text.isEmpty) {
                        SnackbarHelper.showSnackbar(
                            'Please Enter StopLoss or StopProfit Price');
                      } else if (controller.selectedGroupValue.value == 1 &&
                          controller.limitPriceTextController.text.isEmpty) {
                        SnackbarHelper.showSnackbar('Please Enter Price');
                      } else if (controller.stopLossFormKey.currentState!
                          .validate()) {
                        controller.placeContestOrder(
                          type,
                          tradingInstrument,
                        );
                        controller.selectedGroupValue.value = 2;
                        controller.stopLossPriceTextController.clear();
                        controller.stopProfitPriceTextController.clear();
                        controller.limitPriceTextController.clear();
                      }
                    },
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
