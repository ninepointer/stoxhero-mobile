import 'package:flutter/material.dart';

import '../../../app/app.dart';

class TenxTodayOrderCard extends StatelessWidget {
  final TenxTradeOrder order;
  const TenxTodayOrderCard({
    Key? key,
    required this.order,
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
                    value: order.symbol,
                  ),
                  TradeCardTile(
                    isRightAlign: true,
                    label: 'Quantity',
                    value: order.quantity.toString(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TradeCardTile(
                    label: 'Average Price',
                    value: FormatHelper.formatNumbers(
                      order.averagePrice,
                    ),
                  ),
                  TradeCardTile(
                    isRightAlign: true,
                    label: 'Amount',
                    value: FormatHelper.formatNumbers(
                      order.amount,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TradeCardTile(
                    hasBottomMargin: false,
                    label: 'Transaction Type',
                    value: order.buyOrSell,
                    valueColor: order.buyOrSell == "SELL" ? AppColors.danger : AppColors.success,
                  ),
                  TradeCardTile(
                    isRightAlign: true,
                    label: 'Status',
                    value: order.status,
                    valueColor: order.status == "COMPLETE" ? AppColors.success : AppColors.danger,
                    hasBottomMargin: false,
                  ),
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TradeCardTile(
                    hasBottomMargin: true,
                    label: 'Execution Time',
                    value: FormatHelper.formatDateTimeToIST(order.tradeTimeUtc),
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
