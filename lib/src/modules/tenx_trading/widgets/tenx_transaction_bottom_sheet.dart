import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/app.dart';

class TenxTransactionBottomSheet extends GetView<TenxTradingController> {
  final TransactionType type;
  final dynamic marginRequired;
  final TradingInstrument tradingInstrument;

  const TenxTransactionBottomSheet({
    super.key,
    required this.type,
    required this.tradingInstrument,
    required this.marginRequired,
  });

  @override
  build(BuildContext context) {
    controller.selectedGroupValue.value = 2;
    controller.selectedType.value = 'MARKET';
    print('${tradingInstrument.lotSize} ${controller.selectedQuantity.value}');
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
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Regular',
                          style: Theme.of(context).textTheme.tsMedium18,
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
                    height: 36,
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
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 2,
                          groupValue: 1,
                          label: 'Interaday (MIS)',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 1,
                          groupValue: 1,
                          label: 'Overnight (NRML)',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField2<int>(
                    value: controller.selectedQuantity.value,
                    onChanged: (value) => controller.selectedQuantity(value),
                    isDense: true,
                    items: controller.lotsValueList.map((int number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Text(number >= 0 ? number.toString() : number.toString()),
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
                  SizedBox(height: 16),
                  if (controller.selectedGroupValue.value == 3)
                    if (type != TransactionType.exit)
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              isDisabled: controller.handleTextField(
                                    type,
                                    tradingInstrument.lotSize ?? 0,
                                    controller.selectedQuantity.value,
                                  ) ||
                                  controller.selectedGroupValue.value == 2,
                              hintText: 'StopLoss Price',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                              ],
                              controller: controller.stopLossPriceTextController,
                              validator: (value) {
                                final stopLossPrice = double.tryParse(controller.stopLossPriceTextController.text);
                                if (stopLossPrice != null) {
                                  if (type == TransactionType.buy) {
                                    if (stopLossPrice >=
                                        controller.getInstrumentLastPrice(
                                          tradingInstrument.instrumentToken!,
                                          tradingInstrument.exchangeToken!,
                                        )) {
                                      return 'Stop Loss price should \n be less than LTP.';
                                    }
                                  } else if (type == TransactionType.sell) {
                                    if (stopLossPrice <=
                                        controller.getInstrumentLastPrice(
                                          tradingInstrument.instrumentToken!,
                                          tradingInstrument.exchangeToken!,
                                        )) {
                                      return 'Stop Loss price should \n be greater than LTP.';
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
                              isDisabled: controller.handleTextField(
                                    type,
                                    tradingInstrument.lotSize ?? 0,
                                    controller.selectedQuantity.value,
                                  ) ||
                                  controller.selectedGroupValue.value == 2,
                              hintText: 'StopProfit Price',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                              ],
                              controller: controller.stopProfitPriceTextController,
                              validator: (value) {
                                final stopProfitPrice = double.tryParse(controller.stopProfitPriceTextController.text);
                                if (stopProfitPrice != null) {
                                  if (type == TransactionType.buy) {
                                    if (stopProfitPrice <=
                                        controller.getInstrumentLastPrice(
                                          tradingInstrument.instrumentToken!,
                                          tradingInstrument.exchangeToken!,
                                        )) {
                                      return 'Stop Profit price should \n be greater than LTP.';
                                    }
                                  } else if (type == TransactionType.sell) {
                                    if (stopProfitPrice >=
                                        controller.getInstrumentLastPrice(
                                          tradingInstrument.instrumentToken!,
                                          tradingInstrument.exchangeToken!,
                                        )) {
                                      return 'Stop Profit price should \n be less than LTP.';
                                    }
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
                          value: 2,
                          groupValue: controller.selectedGroupValue.value,
                          label: 'MARKET',
                          onChanged: (int value) {
                            controller.handleRadioValueChanged(value, 'MARKET');
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 1,
                          groupValue: 2,
                          label: 'LIMIT',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CommonRadioButtonTile(
                          value: 3,
                          groupValue: controller.selectedGroupValue.value,
                          label: 'SL/SP-M',
                          onChanged: (int value) {
                            controller.handleRadioValueChanged(value, 'SL/SP-M');
                          },
                        ),
                      ),
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
                  CommonCard(
                    margin: EdgeInsets.only(),
                    padding: EdgeInsets.zero.copyWith(left: 12),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Margin Required',
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                          Row(
                            children: [
                              Text(
                                (type == TransactionType.sell || type == TransactionType.exit) &&
                                        tradingInstrument.lotSize == controller.selectedQuantity.value
                                    ? "₹0.0"
                                    : (type == TransactionType.buy ||
                                            (tradingInstrument.lotSize.toString().contains('-') ==
                                                controller.selectedQuantity.value))
                                        ? "₹0.0"
                                        : FormatHelper.formatNumbers(controller.marginRequired.value.margin),
                                style: Theme.of(context).textTheme.tsMedium14,
                              ),
                              IconButton(
                                onPressed: () => controller.getMarginRequired(type, tradingInstrument),
                                icon: Icon(Icons.refresh, size: 18),
                                splashRadius: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CommonFilledButton(
                    isLoading: controller.isTradingOrderSheetLoading.value,
                    backgroundColor: type == TransactionType.exit
                        ? AppColors.warning
                        : type == TransactionType.buy
                            ? AppColors.success
                            : AppColors.danger,
                    margin: EdgeInsets.symmetric(vertical: 24),
                    label: type == TransactionType.exit
                        ? 'Exit'
                        : type == TransactionType.buy
                            ? 'BUY'
                            : 'SELL',
                    onPressed: () {
                      if (controller.selectedGroupValue.value == 3 &&
                          controller.stopLossPriceTextController.text.isEmpty &&
                          controller.stopProfitPriceTextController.text.isEmpty) {
                        SnackbarHelper.showSnackbar('Please Enter StopLoss or StopProfit Price');
                      } else if (controller.stopLossFormKey.currentState!.validate()) {
                        controller.placeTenxTradingOrder(
                          type,
                          tradingInstrument,
                        );
                        controller.selectedGroupValue.value = 2;
                        controller.stopLossPriceTextController.clear();
                        controller.stopProfitPriceTextController.clear();
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
