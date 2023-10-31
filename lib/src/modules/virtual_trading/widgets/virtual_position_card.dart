import 'package:flutter/material.dart';
import '../../../app/app.dart';

class VirtualPositionCard extends GetView<VirtualTradingController> {
  final VirtualTradingPosition position;
  const VirtualPositionCard({super.key, required this.position});

  void openBottomSheet(BuildContext context, TransactionType type) {
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      position.id!.instrumentToken!,
      position.id!.exchangeInstrumentToken!,
    );
    controller.selectedStringQuantity.value = position.lots?.toString() ?? "0";
    controller.generateLotsList(type: position.id?.symbol);
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: VirtualTransactionBottomSheet(
        type: type,
        tradingInstrument: TradingInstrument(
          name: position.id?.symbol,
          exchange: position.id?.exchange,
          tradingsymbol: position.id?.symbol,
          exchangeToken: position.id?.exchangeInstrumentToken,
          instrumentToken: position.id?.instrumentToken,
          lastPrice: lastPrice,
        ),
        margin: controller.getMarginRequired(
          type,
          TradingInstrument(
            name: position.id?.symbol,
            exchange: position.id?.exchange,
            tradingsymbol: position.id?.symbol,
            exchangeToken: position.id?.exchangeInstrumentToken,
            instrumentToken: position.id?.instrumentToken,
            lastPrice: lastPrice,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    num grossPnl = controller.calculateGrossPNL(
      position.amount ?? 0,
      position.lots?.toInt() ?? 0,
      controller.getInstrumentLastPrice(
        position.id?.instrumentToken ?? 0,
        position.id?.exchangeInstrumentToken ?? 0,
      ),
    );
    num ltp = controller.getInstrumentLastPrice(
      position.id?.instrumentToken ?? 0,
      position.id?.exchangeInstrumentToken ?? 0,
    );

    String changes = controller.getInstrumentChanges(
      position.id?.instrumentToken ?? 0,
      position.id?.exchangeInstrumentToken ?? 0,
    );
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
                        valueColor: controller.getValueColor(position.lots == 0 ? position.amount : grossPnl),
                        value: position.lots == 0
                            ? FormatHelper.formatNumbers(position.amount)
                            : FormatHelper.formatNumbers(grossPnl),
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
                        valueColor: controller.getValueColor(ltp),
                        value: FormatHelper.formatNumbers(ltp),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TradeCardTile(
                        hasBottomMargin: false,
                        label: 'Quantity',
                        value: position.lots.toString(),
                      ),
                      TradeCardTile(
                        hasBottomMargin: false,
                        isRightAlign: true,
                        label: 'Changes(%)',
                        valueColor: controller.getValueColor(changes),
                        value: changes,
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
                        style: AppStyles.tsPrimaryMedium12.copyWith(
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
                        style: AppStyles.tsPrimaryMedium12.copyWith(
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
                        print(controller.selectedStringQuantity.value);
                        controller.lotsValueList.assignAll(lots);
                        BottomSheetHelper.openBottomSheet(
                          context: context,
                          child: VirtualTransactionBottomSheet(
                            type: TransactionType.exit,
                            tradingInstrument: TradingInstrument(
                              name: position.id?.symbol,
                              exchange: position.id?.exchange,
                              tradingsymbol: position.id?.symbol,
                              exchangeToken: position.id?.exchangeInstrumentToken,
                              instrumentToken: position.id?.instrumentToken,
                              lotSize: position.lots,
                            ),
                            margin: controller.getMarginRequired(
                              TransactionType.exit,
                              TradingInstrument(
                                name: position.id?.symbol,
                                exchange: position.id?.exchange,
                                tradingsymbol: position.id?.symbol,
                                exchangeToken: position.id?.exchangeInstrumentToken,
                                instrumentToken: position.id?.instrumentToken,
                                lotSize: position.lots,
                              ),
                            ),
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
                        style: AppStyles.tsPrimaryMedium12.copyWith(
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
