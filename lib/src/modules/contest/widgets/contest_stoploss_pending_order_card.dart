import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ContestStoplossPendingOrderCard extends GetView<ContestController> {
  final StopLossPendingOrdersList stopLoss;
  const ContestStoplossPendingOrderCard({
    Key? key,
    required this.stopLoss,
  }) : super(key: key);

  void openBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: ContestStoplossEditPriceBottomSheet(
        stopLoss: StopLossPendingOrdersList(
          id: stopLoss.id,
          type: stopLoss.type,
          symbol: stopLoss.symbol,
          quantity: stopLoss.quantity,
          buyOrSell: stopLoss.buyOrSell,
          instrumentToken: stopLoss.instrumentToken,
          exchangeInstrumentToken: stopLoss.exchangeInstrumentToken,
          price: stopLoss.price,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CommonCard(
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
                      value: stopLoss.symbol,
                    ),
                    TradeCardTile(
                      isRightAlign: true,
                      label: 'Price',
                      value: FormatHelper.formatNumbers(
                        stopLoss.price,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TradeCardTile(
                      label: 'Quantity',
                      value: stopLoss.quantity.toString(),
                    ),
                    TradeCardTile(
                      isRightAlign: true,
                      label: 'LTP (Last Traded Price)',
                      value: FormatHelper.formatNumbers(
                        controller.getInstrumentLastPrice(
                          stopLoss.instrumentToken!,
                          stopLoss.exchangeInstrumentToken!,
                        ),
                      ),
                      valueColor: controller.getValueColor(
                        controller.getInstrumentLastPrice(
                          stopLoss.instrumentToken!,
                          stopLoss.exchangeInstrumentToken!,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TradeCardTile(
                      hasBottomMargin: false,
                      label: 'Type',
                      value: stopLoss.type,
                    ),
                    TradeCardTile(
                      isRightAlign: true,
                      hasBottomMargin: false,
                      label: 'Transaction Type',
                      value: stopLoss.buyOrSell,
                      valueColor: stopLoss.buyOrSell == "SELL"
                          ? AppColors.danger
                          : AppColors.success,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TradeCardTile(
                      label: 'Status',
                      value: stopLoss.status,
                      valueColor: stopLoss.status == "Executed"
                          ? AppColors.success
                          : AppColors.danger,
                      hasBottomMargin: false,
                    ),
                    TradeCardTile(
                      isRightAlign: true,
                      hasBottomMargin: false,
                      label: 'Time',
                      value: FormatHelper.formatDateTimeToIST(stopLoss.time),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => openBottomSheet(context),
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
                      'Modify Price',
                      style: AppStyles.tsPrimaryMedium12.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.getStopLossPendingCancelOrder(stopLoss.id);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.danger.withOpacity(.25),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel Order',
                      style: AppStyles.tsPrimaryMedium12.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
