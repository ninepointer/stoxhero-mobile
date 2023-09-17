import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class VirtualPositionCard extends GetView<VirtualTradingController> {
  final VirtualTradingPosition position;

  const VirtualPositionCard({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
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
                        VirtualWatchListCardTile(
                          label: 'Symbol',
                          value: position.iId?.symbol,
                        ),
                        VirtualWatchListCardTile(
                          isRightAlign: true,
                          label: 'Gross P&L',
                          valueColor: controller.getValueColor(position.amount),
                          value: FormatHelper.formatNumbers(position.amount),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        VirtualWatchListCardTile(
                          label: 'Quantity',
                          value: position.lots.toString(),
                        ),
                        VirtualWatchListCardTile(
                          isRightAlign: true,
                          label: 'Avg. Price',
                          valueColor: controller.getValueColor(position.lastaverageprice),
                          value: FormatHelper.formatNumbers(position.lastaverageprice),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VirtualWatchListCardTile(
                        label: 'LTP',
                        valueColor: controller.getValueColor(position.lastaverageprice),
                        value: FormatHelper.formatNumbers(position.lastaverageprice),
                      ),
                      VirtualWatchListCardTile(
                        isRightAlign: true,
                        label: 'Changes(%)',
                        value: '0.00%',
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
                    onTap: () {
                      log('instrument : ${position.toJson()}');
                      FocusScope.of(context).unfocus();
                      showBottomSheet(
                        context: context,
                        builder: (context) => VirtualTransactionBottomSheet(
                          type: VirtualTransactionType.buy,
                          data: VirtualTradingInstrument(
                            name: position.iId!.symbol,
                            exchange: position.iId!.exchange,
                            tradingsymbol: position.iId!.symbol,
                            exchangeToken: position.iId!.exchangeInstrumentToken,
                            instrumentToken: position.iId!.instrumentToken,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
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
                    onTap: () {
                      log('instrument : ${position.toJson()}');
                      FocusScope.of(context).unfocus();
                      showBottomSheet(
                        context: context,
                        builder: (context) => VirtualTransactionBottomSheet(
                          type: VirtualTransactionType.sell,
                          data: VirtualTradingInstrument(
                            name: position.iId!.symbol,
                            exchange: position.iId!.exchange,
                            tradingsymbol: position.iId!.symbol,
                            exchangeToken: position.iId!.exchangeInstrumentToken,
                            instrumentToken: position.iId!.instrumentToken,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(0.1),
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
                      log('instrument : ${position.toJson()}');
                      FocusScope.of(context).unfocus();
                      // controller.selectedQuantity(position.lots);
                      showBottomSheet(
                        context: context,
                        builder: (context) => VirtualTransactionBottomSheet(
                          type: VirtualTransactionType.exit,
                          data: VirtualTradingInstrument(
                            name: position.iId!.symbol,
                            exchange: position.iId!.exchange,
                            tradingsymbol: position.iId!.symbol,
                            exchangeToken: position.iId!.exchangeInstrumentToken,
                            instrumentToken: position.iId!.instrumentToken,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
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
