import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../app/app.dart';

class ContestPositionCard extends GetView<ContestController> {
  final ContestPosition position;

  const ContestPositionCard({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    void openBottomSheet(BuildContext context, TransactionType type) {
      log('instrument Details: ${position.toJson()}');
      FocusScope.of(context).unfocus();
      num lastPrice = controller.getInstrumentLastPrice(
        position.id?.instrumentToken ?? 0,
        position.id?.exchangeInstrumentToken ?? 0,
      );
      controller.generateLotsList(type: position.id?.symbol);

      if (type == TransactionType.sell) {
        List lotsList = controller.generateLotsList(type: position.id?.symbol);
        int index = lotsList.indexOf(position.lots ?? 0);
        if (index != -1) {
          List<int> newLotsList = controller.lotsValueList.sublist(0, index + 1);
          controller.lotsValueList.value = newLotsList;
        }
      }
      BottomSheetHelper.openBottomSheet(
        context: context,
        child: ContestTransactionBottomSheet(
          type: type,
          tradingInstrument: TradingInstrument(
            name: position.id!.symbol,
            exchange: position.id!.exchange,
            tradingsymbol: position.id!.symbol,
            exchangeToken: position.id!.exchangeInstrumentToken,
            instrumentToken: position.id!.instrumentToken,
            lastPrice: lastPrice,
          ),
        ),
      );
    }

    return Column(
      children: [
        CommonCard(
          hasBorder: false,
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
                        ContestPositionCardTile(
                          label: 'Symbol',
                          value: position.id?.symbol,
                        ),
                        ContestPositionCardTile(
                          isRightAlign: true,
                          label: 'Gross P&L',
                          valueColor: controller.getValueColor(
                            controller.calculateGrossPNL(
                              position.amount!,
                              position.lots!.toInt(),
                              controller.getInstrumentLastPrice(
                                position.id!.instrumentToken!,
                                position.id!.exchangeInstrumentToken!,
                              ),
                            ),
                          ),
                          value: position.lots == 0
                              ? FormatHelper.formatNumbers(position.amount)
                              : FormatHelper.formatNumbers(
                                  controller.calculateGrossPNL(
                                    position.amount!,
                                    position.lots!.toInt(),
                                    controller.getInstrumentLastPrice(
                                      position.id!.instrumentToken!,
                                      position.id!.exchangeInstrumentToken!,
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
                        ContestPositionCardTile(
                          label: 'Avg. Price',
                          value: FormatHelper.formatNumbers(position.lastaverageprice),
                        ),
                        ContestPositionCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          valueColor: controller.getValueColor(position.lastaverageprice),
                          value: FormatHelper.formatNumbers(position.lastaverageprice),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ContestPositionCardTile(
                        label: 'Quantity',
                        value: position.lots.toString(),
                      ),
                      ContestPositionCardTile(
                        isRightAlign: true,
                        label: 'Changes(%)',
                        value: controller.getInstrumentChanges(
                          position.id!.instrumentToken!,
                          position.id!.exchangeInstrumentToken!,
                        ),
                        valueColor: controller.getValueColor(
                          controller.getInstrumentChanges(
                            position.id!.instrumentToken!,
                            position.id!.exchangeInstrumentToken!,
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
                      controller.selectedQuantity.value = position.lots ?? 0;
                      controller.lotsValueList.value = [position.lots ?? 0];
                      num lastPrice = controller.getInstrumentLastPrice(
                        position.id?.instrumentToken ?? 0,
                        position.id?.exchangeInstrumentToken ?? 0,
                      );
                      BottomSheetHelper.openBottomSheet(
                        context: context,
                        child: ContestTransactionBottomSheet(
                          type: TransactionType.exit,
                          tradingInstrument: TradingInstrument(
                            name: position.id!.symbol,
                            exchange: position.id!.exchange,
                            tradingsymbol: position.id!.symbol,
                            exchangeToken: position.id!.exchangeInstrumentToken,
                            instrumentToken: position.id!.instrumentToken,
                            lotSize: position.lots,
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

class ContestPositionCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isRightAlign;
  final Color? valueColor;

  const ContestPositionCardTile({
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
