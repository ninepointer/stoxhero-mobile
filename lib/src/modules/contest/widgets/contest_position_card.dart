import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../data/models/response/contest_instrument_list_response.dart';
import '../../modules.dart';

class ContestPositionCard extends GetView<ContestController> {
  final ContestPosition position;

  const ContestPositionCard({super.key, required this.position});

  void openBottomSheet(BuildContext context, TransactionType type) {
    log('instrument Details: ${position.toJson()}');
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      position.iId?.instrumentToken ?? 0,
      position.iId?.exchangeInstrumentToken ?? 0,
    );
    showBottomSheet(
      context: context,
      builder: (context) => ContestTransactionBottomSheet(
        type: type,
        data: ContestInstrument(
          name: position.iId!.symbol,
          exchange: position.iId!.exchange,
          tradingsymbol: position.iId!.symbol,
          exchangeToken: position.iId!.exchangeInstrumentToken,
          instrumentToken: position.iId!.instrumentToken,
          lastPrice: lastPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // log("Data: ${FormatHelper.formatNumbers(
    //   controller.calculateGrossPNL(
    //     controller.getInstrumentLastPrice(
    //       position.iId!.instrumentToken!,
    //       position.iId!.exchangeInstrumentToken!,
    //     ),
    //     position.lastaverageprice ?? 0,
    //     position.lots!.toInt(),
    //   ),
    // )}");
    // log("${controller.getInstrumentLastPrice(
    //   position.iId!.instrumentToken!,
    //   position.iId!.exchangeInstrumentToken!,
    // )}");
    // log('${position.lastaverageprice}');
    // log('${position.lots!.toInt()}');
    return Column(
      children: [
        CommonCard(
          hasBorder: false,
          margin: EdgeInsets.symmetric(horizontal: 12),
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
                        ContestPositionListCardTile(
                          label: 'Symbol',
                          value: position.iId?.symbol,
                        ),
                        ContestPositionListCardTile(
                          isRightAlign: true,
                          label: 'Gross P&L',
                          valueColor: controller.getValueColor(position.amount),
                          value: FormatHelper.formatNumbers(
                            controller.calculateGrossPNL(
                              controller.getInstrumentLastPrice(
                                position.iId!.instrumentToken!,
                                position.iId!.exchangeInstrumentToken!,
                              ),
                              position.lastaverageprice ?? 0,
                              position.lots!.toInt(),
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
                        ContestPositionListCardTile(
                          isRightAlign: true,
                          label: 'Avg. Price',
                          value: FormatHelper.formatNumbers(position.lastaverageprice),
                          valueColor: AppColors.black,
                        ),
                        ContestPositionListCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          value: FormatHelper.formatNumbers(controller
                              .getInstrumentLastPrice(
                                position.iId!.instrumentToken!,
                                position.iId!.exchangeInstrumentToken!,
                              )
                              .toString()),
                          valueColor: controller.getValueColor(position.lastaverageprice),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ContestPositionListCardTile(
                        label: 'Quantity',
                        value: position.lots.toString(),
                      ),
                      ContestPositionListCardTile(
                        isRightAlign: true,
                        label: 'Changes(%)',
                        value: controller.getInstrumentChanges(
                          position.iId!.instrumentToken!,
                          position.iId!.exchangeInstrumentToken!,
                        ),
                        valueColor: controller.getValueColor(
                          position.iId!.instrumentToken!,
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
                    onTap: () => openBottomSheet(context, TransactionType.exit),
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

class ContestPositionListCardTile extends StatelessWidget {
  final String? label;
  final dynamic value;
  final bool isRightAlign;
  final Color? valueColor;
  const ContestPositionListCardTile({
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
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
