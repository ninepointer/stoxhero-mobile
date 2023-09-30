import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../app/app.dart';

class InternshipPositionCard extends GetView<InternshipController> {
  final InternshipPosition internshipPosition;

  const InternshipPositionCard({super.key, required this.internshipPosition});

  @override
  Widget build(BuildContext context) {
    void openBottomSheet(BuildContext context, TransactionType type) {
      log('instrument Details: ${internshipPosition.toJson()}');
      FocusScope.of(context).unfocus();
      num lastPrice = controller.getInstrumentLastPrice(
        internshipPosition.id?.instrumentToken ?? 0,
        internshipPosition.id?.exchangeInstrumentToken ?? 0,
      );
      controller.generateLotsList(type: internshipPosition.id?.symbol);

      if (type == TransactionType.sell) {
        List lotsList = controller.generateLotsList(type: internshipPosition.id?.symbol);
        int index = lotsList.indexOf(internshipPosition.lots ?? 0);
        if (index != -1) {
          List<int> newLotsList = controller.lotsValueList.sublist(0, index + 1);
          controller.lotsValueList.value = newLotsList;
        }
      }
      BottomSheetHelper.openBottomSheet(
        context: context,
        child: InternshipTransactionBottomSheet(
          type: type,
          tradingInstrument: TradingInstrument(
            name: internshipPosition.id!.symbol,
            exchange: internshipPosition.id!.exchange,
            tradingsymbol: internshipPosition.id!.symbol,
            exchangeToken: internshipPosition.id!.exchangeInstrumentToken,
            instrumentToken: internshipPosition.id!.instrumentToken,
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
                        InternshipPositionCardTile(
                          label: 'Symbol',
                          value: internshipPosition.id?.symbol,
                        ),
                        InternshipPositionCardTile(
                          isRightAlign: true,
                          label: 'Gross P&L',
                          valueColor: controller.getValueColor(
                            controller.calculateGrossPNL(
                              internshipPosition.amount!,
                              internshipPosition.lots!.toInt(),
                              controller.getInstrumentLastPrice(
                                internshipPosition.id!.instrumentToken!,
                                internshipPosition.id!.exchangeInstrumentToken!,
                              ),
                            ),
                          ),
                          value: internshipPosition.lots == 0
                              ? FormatHelper.formatNumbers(internshipPosition.amount)
                              : FormatHelper.formatNumbers(
                                  controller.calculateGrossPNL(
                                    internshipPosition.amount!,
                                    internshipPosition.lots!.toInt(),
                                    controller.getInstrumentLastPrice(
                                      internshipPosition.id!.instrumentToken!,
                                      internshipPosition.id!.exchangeInstrumentToken!,
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
                        InternshipPositionCardTile(
                          label: 'Avg. Price',
                          value: FormatHelper.formatNumbers(internshipPosition.lastaverageprice),
                        ),
                        InternshipPositionCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          valueColor: controller.getValueColor(internshipPosition.lastaverageprice),
                          value: FormatHelper.formatNumbers(internshipPosition.lastaverageprice),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InternshipPositionCardTile(
                        label: 'Quantity',
                        value: internshipPosition.lots.toString(),
                      ),
                      InternshipPositionCardTile(
                        isRightAlign: true,
                        label: 'Changes(%)',
                        value: controller.getInstrumentChanges(
                          internshipPosition.id!.instrumentToken!,
                          internshipPosition.id!.exchangeInstrumentToken!,
                        ),
                        valueColor: controller.getValueColor(
                          controller.getInstrumentChanges(
                            internshipPosition.id!.instrumentToken!,
                            internshipPosition.id!.exchangeInstrumentToken!,
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
                      controller.selectedQuantity.value = internshipPosition.lots ?? 0;
                      controller.lotsValueList.value = [internshipPosition.lots ?? 0];
                      BottomSheetHelper.openBottomSheet(
                        context: context,
                        child: InternshipTransactionBottomSheet(
                          type: TransactionType.exit,
                          tradingInstrument: TradingInstrument(
                            name: internshipPosition.id!.symbol,
                            exchange: internshipPosition.id!.exchange,
                            tradingsymbol: internshipPosition.id!.symbol,
                            exchangeToken: internshipPosition.id!.exchangeInstrumentToken,
                            instrumentToken: internshipPosition.id!.instrumentToken,
                            lotSize: internshipPosition.lots,
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

class InternshipPositionCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isRightAlign;
  final Color? valueColor;

  const InternshipPositionCardTile({
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
