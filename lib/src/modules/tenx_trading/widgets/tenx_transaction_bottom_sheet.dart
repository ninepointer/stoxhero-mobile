import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/app.dart';

class TenxTransactionBottomSheet extends GetView<TenxTradingController> {
  final TransactionType type;
  final TradingInstrument tradingInstrument;

  const TenxTransactionBottomSheet({
    super.key,
    required this.type,
    required this.tradingInstrument,
  });

  @override
  build(BuildContext context) {
    final ltp = controller.getInstrumentLastPrice(
      tradingInstrument.instrumentToken ?? 0,
      tradingInstrument.exchangeToken ?? 0,
    );
    log('tradingInstrument.lotSize ${tradingInstrument.lotSize}');
    log('POstioon.lotSize ${controller.tenxPosition.value.lots}');
    log('POstioon.lotSize ${controller.selectedQuantity.value}');
    log('Type $type');
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
                            ? FormatHelper.formatNumbers(ltp)
                            : type == TransactionType.sell
                                ? FormatHelper.formatNumbers(ltp)
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
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          isDisabled: controller.selectedGroupValue.value != 3,
                          hintText: 'StopLoss Price',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                          ],
                          controller: controller.stopLossPriceTextController,
                          validator: (value) {
                            final stopLossPrice = double.tryParse(controller.stopLossPriceTextController.text);
                            if (stopLossPrice != null) {
                              if (type == TransactionType.buy) {
                                if (stopLossPrice >= ltp) {
                                  return 'Stop Loss price should \n be less than LTP.';
                                }
                              } else if (type == TransactionType.sell) {
                                if (stopLossPrice <= ltp) {
                                  return 'Stop Loss price should \n be greater than LTP.';
                                }
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: CommonTextField(
                          isDisabled: controller.selectedGroupValue.value != 3,
                          hintText: 'StopProfit Price',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                          ],
                          controller: controller.stopProfitPriceTextController,
                          validator: (value) {
                            final stopProfitPrice = double.tryParse(controller.stopProfitPriceTextController.text);
                            if (stopProfitPrice != null) {
                              if (type == TransactionType.buy) {
                                if (stopProfitPrice <= ltp) {
                                  return 'Stop Profit price should \n be greater than LTP.';
                                }
                              } else if (type == TransactionType.sell) {
                                if (stopProfitPrice >= ltp) {
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
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
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
                      if (controller.stopLossFormKey.currentState!.validate()) {
                        Get.find<TenxTradingController>().placeTenxTradingOrder(
                          type,
                          tradingInstrument,
                        );
                      }
                      controller.stopLossPriceTextController.clear();
                      controller.stopProfitPriceTextController.clear();
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

// if (transaction.lotSize==position.lots){ 
// type==TransactionType.buy
// TextField enable
// }

//else if(transaction.lotSize<postiton.lots){
// type==TransactionType.buy
// TextField enable
// }

//else if(transcation.lotssize==position.lots){
// type==TransactionType.sell
// TextField disable
// }

//else if(transaction.lotSize<position.lots){
// type==TransactionType.sell
// TextField disable
// }

//else if(transaction.lotSize.contain('-')==postion.lots){
// type==TransactionType.buy
// TextField disable
// }

//else if(transaction.lotSize.contrain('-')<postion.lots){
// type==TransactionType.buy
// TextField enable
// }

//else if(transaction.lotSize.contrain('-')==postion.lots){
// type==TransactionType.sell
// TextField enable
// }

//else if(transaction.lotSize.contrain('-')<postion.lots){
// type==TransactionType.sell
// TextField enable
// }



