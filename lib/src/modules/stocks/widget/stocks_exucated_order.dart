import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../core/core.dart';

class StocksExcuatedOrderCard extends StatelessWidget {
  final StocksExcuatedOrderData stopLoss;
  const StocksExcuatedOrderCard({
    Key? key,
    required this.stopLoss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 170,
        width: double.infinity,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(25.0), // Adjust the radius as needed
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //status,
                    stopLoss.status ?? '',
                    style: AppStyles.tsBlackSemiBold16.copyWith(
                      color: stopLoss.status == "COMPLETE"
                          ? AppColors.success
                          : AppColors.danger,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    stopLoss.symbol ?? '',
                    style: AppStyles.tsBlackMedium14,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Price ",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    //  "₹$price",
                    FormatHelper.formatNumbers(
                      stopLoss.executionPrice,
                    ),
                    style: AppStyles.tsBlackMedium14,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Timestamp",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    //timestamp,
                    FormatHelper.formatDateTimeToIST(stopLoss.executionTime),
                    style: AppStyles.tsBlackMedium14,
                  ),
                ],
              ),

              // Right side
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      //type,
                      stopLoss.buyOrSell ?? '',
                      style: AppStyles.tsBlackSemiBold16.copyWith(
                        color: stopLoss.buyOrSell == "SELL"
                            ? AppColors.danger
                            : AppColors.success,
                      )),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        stopLoss.quantity.toString(),
                        style: AppStyles.tsBlackMedium12,
                      ),
                      Text(
                        " Quantity",
                        style: AppStyles.tsGreyRegular12,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Amount",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    // "₹$totalamount",
                    FormatHelper.formatNumbers(
                      stopLoss.amount,
                    ),
                    style: AppStyles.tsBlackMedium14,
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
