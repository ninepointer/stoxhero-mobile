import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class TenxPositionCard extends GetView<TenxTradingController> {
  final TenxTradingPosition data;

  const TenxPositionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCard(
          hasBorder: false,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          children: [
            Divider(
              thickness: 1,
              height: 0,
            ),
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
                          value: data.id?.symbol,
                        ),
                        TenxPositionCardTile(
                          isRightAlign: true,
                          label: 'Gross P&L',
                          valueColor: controller.getValueColor(00),
                          value: '₹ 0.00',
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
                          label: 'Quantity',
                          value: data.lots.toString(),
                        ),
                        TenxPositionCardTile(
                          isRightAlign: true,
                          label: 'Avg. Price',
                          valueColor: controller.getValueColor(data.amount),
                          value: FormatHelper.formatNumbers(data.amount),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TenxPositionCardTile(
                        label: 'LTP',
                        valueColor: controller.getValueColor(data.lastaverageprice),
                        value: FormatHelper.formatNumbers(data.lastaverageprice),
                      ),
                      TenxPositionCardTile(
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
                      log('instrument : ${data.toJson()}');
                      FocusScope.of(context).unfocus();
                      showBottomSheet(
                        context: context,
                        builder: (context) => TenxTransactionBottomSheet(
                          type: TransactionType.buy,
                          data: TenxTradingInstrument(
                            name: data.id!.symbol,
                            exchange: data.id!.exchange,
                            tradingsymbol: data.id!.symbol,
                            exchangeToken: data.id!.exchangeInstrumentToken,
                            instrumentToken: data.id!.instrumentToken,
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
                          bottomLeft: Radius.circular(4),
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
                      log('instrument : ${data.toJson()}');
                      FocusScope.of(context).unfocus();
                      showBottomSheet(
                        context: context,
                        builder: (context) => TenxTransactionBottomSheet(
                          type: TransactionType.sell,
                          data: TenxTradingInstrument(
                            name: data.id!.symbol,
                            exchange: data.id!.exchange,
                            tradingsymbol: data.id!.symbol,
                            exchangeToken: data.id!.exchangeInstrumentToken,
                            instrumentToken: data.id!.instrumentToken,
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
                      log('instrument : ${data.toJson()}');
                      FocusScope.of(context).unfocus();
                      controller.selectedQuantity(data.lots);
                      showBottomSheet(
                        context: context,
                        builder: (context) => TenxTransactionBottomSheet(
                          type: TransactionType.exit,
                          data: TenxTradingInstrument(
                            name: data.id!.symbol,
                            exchange: data.id!.exchange,
                            tradingsymbol: data.id!.symbol,
                            exchangeToken: data.id!.exchangeInstrumentToken,
                            instrumentToken: data.id!.instrumentToken,
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
                          bottomRight: Radius.circular(4),
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
        Divider(
          thickness: 1,
          height: 0,
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
          style: AppStyles.tsGreyRegular10,
        ),
        SizedBox(height: 2),
        Text(
          value ?? '-',
          style: AppStyles.tsWhiteRegular14.copyWith(
            color: valueColor ?? AppColors.white,
          ),
        ),
      ],
    );
  }
}
