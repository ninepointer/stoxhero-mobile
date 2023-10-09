import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ContestPositionCard extends GetView<ContestController> {
  final ContestPosition position;
  const ContestPositionCard({super.key, required this.position});

  void openBottomSheet(BuildContext context, TransactionType type) {
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      position.id!.instrumentToken!,
      position.id!.exchangeInstrumentToken!,
    );
    controller.generateLotsList(type: position.id?.symbol);
    controller.selectedStringQuantity.value = position.lots?.toString() ?? "0";
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: ContestTransactionBottomSheet(
        type: type,
        tradingInstrument: TradingInstrument(
          name: position.id?.symbol,
          exchange: position.id?.exchange,
          tradingsymbol: position.id?.symbol,
          exchangeToken: position.id?.exchangeInstrumentToken,
          instrumentToken: position.id?.instrumentToken,
          lastPrice: lastPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCard(
          hasBorder: false,
          margin: EdgeInsets.all(8).copyWith(bottom: 0),
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            position.lots == 0
                                ? position.amount
                                : controller.calculateGrossPNL(
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
                          value: FormatHelper.formatNumbers(
                            position.lastaverageprice,
                          ),
                        ),
                        ContestPositionCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          value: FormatHelper.formatNumbers(
                            controller.getInstrumentLastPrice(
                              position.id!.instrumentToken!,
                              position.id!.exchangeInstrumentToken!,
                            ),
                          ),
                          valueColor: controller.getValueColor(
                            controller.getInstrumentLastPrice(
                              position.id!.instrumentToken!,
                              position.id!.exchangeInstrumentToken!,
                            ),
                          ),
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
                          position.id?.instrumentToken ?? 0,
                          position.id?.exchangeInstrumentToken ?? 0,
                        ),
                        valueColor: controller.getValueColor(
                          controller.getInstrumentChanges(
                            position.id?.instrumentToken ?? 0,
                            position.id?.exchangeInstrumentToken ?? 0,
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
                      padding: EdgeInsets.all(8),
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
                      padding: EdgeInsets.all(8),
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
                      List<int> lots = controller.generateLotsList(type: position.id?.symbol);
                      int exitLots = position.lots!.toInt();
                      int maxLots = lots.last;
                      log('selectedQuantity ${controller.selectedQuantity.value}');
                      if (exitLots == 0) {
                        SnackbarHelper.showSnackbar('You do not have any open position for this symbol.');
                      } else {
                        log(exitLots.toString());
                        log(maxLots.toString());
                        if (exitLots.toString().contains('-')) {
                          if (exitLots < 0) {
                            exitLots = -exitLots;
                          }

                          if (!lots.contains(exitLots)) {
                            lots.add(exitLots);
                            lots.sort();
                          }
                          controller.selectedQuantity.value = exitLots;
                        }

                        if (exitLots > maxLots) {
                          controller.selectedQuantity.value = maxLots;
                        } else {
                          controller.selectedQuantity.value = exitLots;
                        }
                        controller.selectedStringQuantity.value = position.lots?.toString() ?? "0";
                        controller.lotsValueList.assignAll(lots);
                        BottomSheetHelper.openBottomSheet(
                          context: context,
                          child: ContestTransactionBottomSheet(
                            type: TransactionType.exit,
                            tradingInstrument: TradingInstrument(
                              name: position.id?.symbol,
                              exchange: position.id?.exchange,
                              tradingsymbol: position.id?.symbol,
                              exchangeToken: position.id?.exchangeInstrumentToken,
                              instrumentToken: position.id?.instrumentToken,
                              lotSize: position.lots,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
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
  final dynamic value;
  final bool isRightAlign;
  final Color? valueColor;
  const ContestPositionCardTile({
    super.key,
    required this.label,
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
          style: AppStyles.tsGreyMedium12,
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
              ),
        ),
      ],
    );
  }
}
