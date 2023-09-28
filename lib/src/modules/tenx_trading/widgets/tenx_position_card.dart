import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../app/app.dart';

class TenxPositionCard extends GetView<TenxTradingController> {
  final TenxTradingPosition tenxTradingPosition;

  const TenxPositionCard({super.key, required this.tenxTradingPosition});

  @override
  Widget build(BuildContext context) {
    // void openBottomSheet(BuildContext context, TransactionType type) {
    //   // log('instrument Details: ${position.toJson()}');
    //   FocusScope.of(context).unfocus();
    //   num lastPrice = controller.getInstrumentLastPrice(
    //     data.id?.instrumentToken ?? 0,
    //     data.id?.exchangeInstrumentToken ?? 0,
    //   );
    //   showBottomSheet(
    //     context: context,
    //     builder: (context) => TenxTransactionBottomSheet(
    //       type: type,
    //       data: TradingInstrument(
    //         name: data.id!.symbol,
    //         exchange: data.id!.exchange,
    //         tradingsymbol: data.id!.symbol,
    //         exchangeToken: data.id!.exchangeInstrumentToken,
    //         instrumentToken: data.id!.instrumentToken,
    //         lastPrice: lastPrice,
    //       ),
    //     ),
    //   );
    // }

    void openBottomSheet(BuildContext context, TransactionType type) {
      log('instrument Details: ${tenxTradingPosition.toJson()}');
      FocusScope.of(context).unfocus();
      num lastPrice = controller.getInstrumentLastPrice(
        tenxTradingPosition.id?.instrumentToken ?? 0,
        tenxTradingPosition.id?.exchangeInstrumentToken ?? 0,
      );
      controller.generateLotsList(type: tenxTradingPosition.id?.symbol);
      showBottomSheet(
        context: context,
        builder: (context) {
          return TenxTransactionBottomSheet(
            type: type,
            tradingInstrument: TradingInstrument(
              name: tenxTradingPosition.id!.symbol,
              exchange: tenxTradingPosition.id!.exchange,
              tradingsymbol: tenxTradingPosition.id!.symbol,
              exchangeToken: tenxTradingPosition.id!.exchangeInstrumentToken,
              instrumentToken: tenxTradingPosition.id!.instrumentToken,
              lastPrice: lastPrice,
            ),
          );
        },
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
                          valueColor: controller.getValueColor(tenxTradingPosition.amount),
                          value: tenxTradingPosition.lots == 0
                              ? FormatHelper.formatNumbers(tenxTradingPosition.amount)
                              : FormatHelper.formatNumbers(
                                  controller.calculateGrossPNL(
                                    controller.getInstrumentLastPrice(
                                      tenxTradingPosition.id?.instrumentToken ?? 0,
                                      tenxTradingPosition.id?.exchangeInstrumentToken ?? 0,
                                    ),
                                    tenxTradingPosition.lastaverageprice ?? 0,
                                    tenxTradingPosition.lots ?? 0,
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
                          // valueColor: AppColors.black,
                          value: FormatHelper.formatNumbers(tenxTradingPosition.lastaverageprice),
                        ),
                        TenxPositionCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          valueColor:
                              controller.getValueColor(tenxTradingPosition.lastaverageprice),
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
                          tenxTradingPosition.id!.instrumentToken!,
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
                    // onTap: () {
                    //   log('instrument : ${data.toJson()}');
                    //   FocusScope.of(context).unfocus();
                    //   showBottomSheet(
                    //     context: context,
                    //     builder: (context) => TenxTransactionBottomSheet(
                    //       type: TransactionType.buy,
                    //       data: TenxTradingInstrument(
                    //         name: data.id!.symbol,
                    //         exchange: data.id!.exchange,
                    //         tradingsymbol: data.id!.symbol,
                    //         exchangeToken: data.id!.exchangeInstrumentToken,
                    //         instrumentToken: data.id!.instrumentToken,
                    //       ),
                    //     ),
                    //   );
                    // },
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
                      List<int> lots =
                          controller.generateLotsList(type: tenxTradingPosition.id?.symbol);
                      controller.selectedQuantity.value = tenxTradingPosition.lots ?? 0;
                      controller.lotsValueList.assignAll(lots);
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return TenxTransactionBottomSheet(
                            type: TransactionType.exit,
                            tradingInstrument: TradingInstrument(
                              name: tenxTradingPosition.id!.symbol,
                              exchange: tenxTradingPosition.id!.exchange,
                              tradingsymbol: tenxTradingPosition.id!.symbol,
                              exchangeToken: tenxTradingPosition.id!.exchangeInstrumentToken,
                              instrumentToken: tenxTradingPosition.id!.instrumentToken,
                              lotSize: tenxTradingPosition.lots,
                            ),
                          );
                        },
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
