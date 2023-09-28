import 'package:flutter/material.dart';
import '../../../app/app.dart';

class VirtualPositionCard extends GetView<VirtualTradingController> {
  final VirtualTradingPosition position;
  const VirtualPositionCard({super.key, required this.position});

  void openBottomSheet(BuildContext context, TransactionType type) {
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      position.id?.instrumentToken ?? 0,
      position.id?.exchangeInstrumentToken ?? 0,
    );
    controller.generateLotsList(type: position.id?.symbol);
    showBottomSheet(
      context: context,
      builder: (context) {
        return VirtualTransactionBottomSheet(
          type: type,
          tradingInstrument: TradingInstrument(
            name: position.id?.symbol,
            exchange: position.id?.exchange,
            tradingsymbol: position.id?.symbol,
            exchangeToken: position.id?.exchangeInstrumentToken,
            instrumentToken: position.id?.instrumentToken,
            lastPrice: lastPrice,
          ),
        );
      },
    );
  }

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
                        PositionListCardTile(
                          label: 'Symbol',
                          value: position.id?.symbol,
                        ),
                        PositionListCardTile(
                          isRightAlign: true,
                          label: 'Gross P&L',
                          value: position.lots == 0
                              ? FormatHelper.formatNumbers(position.amount)
                              : FormatHelper.formatNumbers(
                                  controller.calculateGrossPNL(
                                    controller.getInstrumentLastPrice(
                                      position.id?.instrumentToken ?? 0,
                                      position.id?.exchangeInstrumentToken ?? 0,
                                    ),
                                    position.lastaverageprice ?? 0,
                                    position.lots ?? 0,
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
                        PositionListCardTile(
                          label: 'Avg. Price',
                          value: FormatHelper.formatNumbers(position.lastaverageprice),
                        ),
                        PositionListCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          value: FormatHelper.formatNumbers(
                            controller.getInstrumentLastPrice(
                              position.id?.instrumentToken ?? 0,
                              position.id?.exchangeInstrumentToken ?? 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PositionListCardTile(
                        label: 'Quantity',
                        value: position.lots.toString(),
                      ),
                      PositionListCardTile(
                        isRightAlign: true,
                        label: 'Changes(%)',
                        value: controller.getInstrumentChanges(
                          position.id?.instrumentToken ?? 0,
                          position.id?.exchangeInstrumentToken ?? 0,
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
                      List<int> lots = controller.generateLotsList(type: position.id?.symbol);
                      controller.selectedQuantity.value = position.lots!.toInt();
                      controller.lotsValueList.assignAll(lots);
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return VirtualTransactionBottomSheet(
                            type: TransactionType.exit,
                            tradingInstrument: TradingInstrument(
                              name: position.id?.symbol,
                              exchange: position.id?.exchange,
                              tradingsymbol: position.id?.symbol,
                              exchangeToken: position.id?.exchangeInstrumentToken,
                              instrumentToken: position.id?.instrumentToken,
                              lotSize: position.lots,
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

class PositionListCardTile extends StatelessWidget {
  final String? label;
  final dynamic value;
  final bool isRightAlign;
  final Color? valueColor;
  const PositionListCardTile({
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
                color: valueColor ?? (value.startsWith('-') ? AppColors.danger : AppColors.success),
              ),
        ),
      ],
    );
  }
}
