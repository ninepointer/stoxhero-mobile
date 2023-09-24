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
    void openBottomSheet(BuildContext context, TransactionType type) {
      // log('instrument Details: ${position.toJson()}');
      FocusScope.of(context).unfocus();
      num lastPrice = controller.getInstrumentLastPrice(
        data.id?.instrumentToken ?? 0,
        data.id?.exchangeInstrumentToken ?? 0,
      );
      showBottomSheet(
        context: context,
        builder: (context) => VirtualTransactionBottomSheet(
          type: type,
          data: VirtualTradingInstrument(
            name: data.id!.symbol,
            exchange: data.id!.exchange,
            tradingsymbol: data.id!.symbol,
            exchangeToken: data.id!.exchangeInstrumentToken,
            instrumentToken: data.id!.instrumentToken,
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
                          value: data.id?.symbol,
                        ),
                        TenxPositionCardTile(
                          isRightAlign: true,
                          label: 'Gross P&L',
                          valueColor: controller.getValueColor(data.amount),
                          value: FormatHelper.formatNumbers(
                            controller.calculateGrossPNL(
                              controller.getInstrumentLastPrice(
                                data.id!.instrumentToken!,
                                data.id!.exchangeInstrumentToken!,
                              ),
                              data.lastaverageprice ?? 0,
                              data.lots!.toInt(),
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
                          isRightAlign: true,
                          label: 'Avg. Price',
                          valueColor: AppColors.black,
                          value: FormatHelper.formatNumbers(data.lastaverageprice),
                        ),
                        TenxPositionCardTile(
                          label: 'LTP',
                          valueColor: controller.getValueColor(data.lastaverageprice),
                          value: FormatHelper.formatNumbers(data.lastaverageprice),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TenxPositionCardTile(
                        label: 'Quantity',
                        value: data.lots.toString(),
                      ),
                      TenxPositionCardTile(
                        isRightAlign: true,
                        label: 'Changes(%)',
                        value: controller.getInstrumentChanges(
                          data.id!.instrumentToken!,
                          data.id!.exchangeInstrumentToken!,
                        ),
                        valueColor: controller.getValueColor(
                          data.id!.instrumentToken!,
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
                    onTap: () => openBottomSheet(context, TransactionType.sell),
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
                    onTap: () => openBottomSheet(context, TransactionType.exit),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
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
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
