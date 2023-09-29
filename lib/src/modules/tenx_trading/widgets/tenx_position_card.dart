import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../app/app.dart';

class TenxPositionCard extends GetView<TenxTradingController> {
  final TenxTradingPosition tenxTradingPosition;

  const TenxPositionCard({super.key, required this.tenxTradingPosition});

  @override
  Widget build(BuildContext context) {
    void openBottomSheet(BuildContext context, TransactionType type) {
      log('instrument Details: ${tenxTradingPosition.toJson()}');
      FocusScope.of(context).unfocus();
      num lastPrice = controller.getInstrumentLastPrice(
        tenxTradingPosition.id?.instrumentToken ?? 0,
        tenxTradingPosition.id?.exchangeInstrumentToken ?? 0,
      );
      controller.generateLotsList(type: tenxTradingPosition.id?.symbol);

      if (type == TransactionType.sell) {
        List lotsList = controller.generateLotsList(type: tenxTradingPosition.id?.symbol);
        int index = lotsList.indexOf(tenxTradingPosition.lots ?? 0);
        if (index != -1) {
          List<int> newLotsList = controller.lotsValueList.sublist(0, index + 1);
          controller.lotsValueList.value = newLotsList;
        }
      }
      BottomSheetHelper.openBottomSheet(
        context: context,
        child: TenxTransactionBottomSheet(
          type: type,
          tradingInstrument: TradingInstrument(
            name: tenxTradingPosition.id!.symbol,
            exchange: tenxTradingPosition.id!.exchange,
            tradingsymbol: tenxTradingPosition.id!.symbol,
            exchangeToken: tenxTradingPosition.id!.exchangeInstrumentToken,
            instrumentToken: tenxTradingPosition.id!.instrumentToken,
            lastPrice: lastPrice,
          ),
        ),
      );
    }

    return Column(
      children: [
        CommonCard(
          margin: EdgeInsets.all(8).copyWith(
            bottom: 0,
          ),
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TenxPositionCardTile(
                          label: 'Symbol',
                          value: tenxTradingPosition.id?.symbol,
                        ),
                        TenxPositionCardTile(
                          isRightAlign: true,
                          label: 'Gross P&L',
                          valueColor: controller.getValueColor(
                            controller.calculateGrossPNL(
                              tenxTradingPosition.amount!,
                              tenxTradingPosition.lots!.toInt(),
                              controller.getInstrumentLastPrice(
                                tenxTradingPosition.id!.instrumentToken!,
                                tenxTradingPosition.id!.exchangeInstrumentToken!,
                              ),
                            ),
                          ),
                          value: tenxTradingPosition.lots == 0
                              ? FormatHelper.formatNumbers(tenxTradingPosition.amount)
                              : FormatHelper.formatNumbers(
                                  controller.calculateGrossPNL(
                                    tenxTradingPosition.amount!,
                                    tenxTradingPosition.lots!.toInt(),
                                    controller.getInstrumentLastPrice(
                                      tenxTradingPosition.id!.instrumentToken!,
                                      tenxTradingPosition.id!.exchangeInstrumentToken!,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TenxPositionCardTile(
                          label: 'Avg. Price',
                          value: FormatHelper.formatNumbers(tenxTradingPosition.lastaverageprice),
                        ),
                        TenxPositionCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          valueColor: controller.getValueColor(tenxTradingPosition.lastaverageprice),
                          value: FormatHelper.formatNumbers(tenxTradingPosition.lastaverageprice),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TenxPositionCardTile(
                        label: 'Quantity',
                        value: tenxTradingPosition.lots.toString(),
                      ),
                      TenxPositionCardTile(
                        isRightAlign: true,
                        label: 'Changes(%)',
                        value: controller.getInstrumentChanges(
                          tenxTradingPosition.id!.instrumentToken!,
                          tenxTradingPosition.id!.exchangeInstrumentToken!,
                        ),
                        valueColor: controller.getValueColor(
                          controller.getInstrumentChanges(
                            tenxTradingPosition.id!.instrumentToken!,
                            tenxTradingPosition.id!.exchangeInstrumentToken!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => openBottomSheet(context, TransactionType.buy),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(.25),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        'BUY',
                        style: AppStyles.tsPrimaryMedium14.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => openBottomSheet(context, TransactionType.sell),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(.25),
                      ),
                      child: Text(
                        'SELL',
                        style: AppStyles.tsPrimaryMedium14.copyWith(
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      controller.selectedQuantity.value = tenxTradingPosition.lots ?? 0;
                      controller.lotsValueList.value = [tenxTradingPosition.lots ?? 0];
                      num lastPrice = controller.getInstrumentLastPrice(
                        tenxTradingPosition.id?.instrumentToken ?? 0,
                        tenxTradingPosition.id?.exchangeInstrumentToken ?? 0,
                      );
                      BottomSheetHelper.openBottomSheet(
                        context: context,
                        child: TenxTransactionBottomSheet(
                          type: TransactionType.exit,
                          tradingInstrument: TradingInstrument(
                            name: tenxTradingPosition.id!.symbol,
                            exchange: tenxTradingPosition.id!.exchange,
                            tradingsymbol: tenxTradingPosition.id!.symbol,
                            exchangeToken: tenxTradingPosition.id!.exchangeInstrumentToken,
                            instrumentToken: tenxTradingPosition.id!.instrumentToken,
                            lotSize: tenxTradingPosition.lots,
                            lastPrice: lastPrice,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(.25),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        'EXIT',
                        style: AppStyles.tsPrimaryMedium14.copyWith(
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class TenxPositionCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isRightAlign;
  final Color? valueColor;

  const TenxPositionCardTile({
    super.key,
    this.label,
    this.value,
    this.isRightAlign = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '-',
          style: AppStyles.tsGreyRegular12,
        ),
        SizedBox(height: 2),
        Text(
          value ?? '-',
          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
              ),
        ),
      ],
    );
  }
}
