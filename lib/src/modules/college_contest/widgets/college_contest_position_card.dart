import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CollegeContestPositionCard extends GetView<CollegeContestController> {
  final TradingPosition position;
  const CollegeContestPositionCard({super.key, required this.position});

  void openBottomSheet(BuildContext context, TransactionType type) {
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      position.id!.instrumentToken!,
      position.id!.exchangeInstrumentToken!,
    );
    controller.selectedStringQuantity.value = position.lots?.toString() ?? "0";
    controller.generateLotsList(type: position.id?.symbol);
    TradingInstrument trading = TradingInstrument(
      name: position.id?.symbol,
      exchange: position.id?.exchange,
      tradingsymbol: position.id?.symbol,
      exchangeToken: position.id?.exchangeInstrumentToken,
      instrumentToken: position.id?.instrumentToken,
      lastPrice: lastPrice,
      lotSize: position.lots,
    );
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: CollegeContestTransactionBottomSheet(
        type: type,
        tradingInstrument: trading,
        marginRequired: controller.getMarginRequired(type, trading),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TradeCardTile(
                        label: 'Symbol',
                        value: position.id?.symbol,
                      ),
                      TradeCardTile(
                        isRightAlign: true,
                        label: 'Gross P&L (Profit & Loss)',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TradeCardTile(
                        label: 'Average Price',
                        value: FormatHelper.formatNumbers(
                          position.lastaverageprice,
                        ),
                      ),
                      TradeCardTile(
                        isRightAlign: true,
                        label: 'LTP (Last Traded Price)',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TradeCardTile(
                        label: 'Quantity',
                        value: position.lots.toString(),
                      ),
                      TradeCardTile(
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
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(.25),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        position.lots == 0 ? 'BUY' : 'ADD MORE',
                        style: AppStyles.tsWhiteMedium12.copyWith(
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
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(.25),
                      ),
                      child: Text(
                        position.lots == 0 ? 'SELL' : 'EXIT SOME',
                        style: AppStyles.tsWhiteMedium12.copyWith(
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

                      if (exitLots == 0) {
                        SnackbarHelper.showSnackbar("You don't have any open position for this symbol.");
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
                        TradingInstrument trading = TradingInstrument(
                          name: position.id?.symbol,
                          exchange: position.id?.exchange,
                          tradingsymbol: position.id?.symbol,
                          exchangeToken: position.id?.exchangeInstrumentToken,
                          instrumentToken: position.id?.instrumentToken,
                          lotSize: position.lots,
                          lastPrice: controller.getInstrumentLastPrice(
                            position.id!.instrumentToken!,
                            position.id!.exchangeInstrumentToken!,
                          ),
                        );
                        BottomSheetHelper.openBottomSheet(
                          context: context,
                          child: CollegeContestTransactionBottomSheet(
                            type: TransactionType.exit,
                            tradingInstrument: trading,
                            marginRequired: controller.getMarginRequired(TransactionType.exit, trading),
                          ),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(.25),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        'EXIT ALL',
                        style: AppStyles.tsWhiteMedium12.copyWith(
                          color: AppColors.secondary.shade600,
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
