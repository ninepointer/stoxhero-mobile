import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class StoplossExecutedOrderCard extends StatelessWidget {
  final StopLossExecutedOrdersList stopLoss;
  const StoplossExecutedOrderCard({
    Key? key,
    required this.stopLoss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
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
                    label: 'SL/SP Price',
                    value: FormatHelper.formatNumbers(
                      stopLoss.executionPrice,
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
                    label: 'Amount',
                    value: FormatHelper.formatNumbers(
                      stopLoss.amount,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TradeCardTile(
                    hasBottomMargin: false,
                    label: 'Stop Type',
                    value: stopLoss.type,
                  ),
                  TradeCardTile(
                    isRightAlign: true,
                    hasBottomMargin: false,
                    label: 'Type',
                    value: stopLoss.buyOrSell,
                    valueColor: stopLoss.buyOrSell == "SELL" ? AppColors.danger : AppColors.success,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TradeCardTile(
                    label: 'Status',
                    value: stopLoss.status,
                    valueColor: stopLoss.status == "Executed" ? AppColors.success : AppColors.danger,
                    hasBottomMargin: false,
                  ),
                  TradeCardTile(
                    isRightAlign: true,
                    hasBottomMargin: true,
                    label: 'Time',
                    value: FormatHelper.formatDateTimeToIST(stopLoss.time),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
