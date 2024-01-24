import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../core/core.dart';

class StocksPendingOrderCard extends GetView<StocksTradingController> {
  final StocksPendingOrderData stopLoss;
  final StockTradingHolding holding;
  const StocksPendingOrderCard({
    Key? key,
    required this.stopLoss,
    required this.holding,
  }) : super(key: key);
  // final StockTradingPosition position;

  void openBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();

    BottomSheetHelper.openBottomSheet(
      context: context,
      child: StocksStoplossEditPriceBottomSheet(
        stopLoss: StocksPendingOrderData(
          sId: stopLoss.sId,
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
    print("stoplosss${stopLoss.toJson()}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 195,
        width: double.infinity,
        padding: EdgeInsets.only(left: 9, right: 9),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
          borderRadius:
              BorderRadius.circular(25.0), // Adjust the radius as needed
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? Color(0xFF151F2B).withOpacity(0.8)
                  : Colors.grey.withOpacity(0.2),
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
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Price ",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    //  "₹$price",
                    FormatHelper.formatNumbers(
                      stopLoss.price,
                    ),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Timestamp",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    //timestamp,
                    FormatHelper.formatDateTimeToIST(stopLoss.executionTime),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 7),
                  InkWell(
                    onTap: () {
                      controller.getStopLossPendingCancelOrder(stopLoss.sId);
                    },
                    child: Container(
                      width: 163.35,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(.6),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        'CANCEL',
                        style: AppStyles.tsWhiteSemiBold16
                        // .copyWith(color: AppColors.danger)
                        ,
                      ),
                    ),
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
                        style: AppStyles.tsBlackMedium12.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                      Text(
                        " Quantity",
                        style: AppStyles.tsGreyRegular12,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "LTP",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    // "₹$totalamount",

                    FormatHelper.formatNumbers(
                        controller.getInstrumentLastPrice(
                      stopLoss.instrumentToken!,
                      stopLoss.exchangeInstrumentToken!,
                    )),

                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Type",
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    // "₹$totalamount",

                    stopLoss.type.toString(),
                    style: AppStyles.tsBlackMedium14.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(height: 7),
                  InkWell(
                    onTap: () => openBottomSheet(context),
                    // Your onTap logic goes here
                    // For example, you can show a dialog or navigate to another screen

                    child: Container(
                      width: 163.35,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(.6),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Text('MODIFY', style: AppStyles.tsWhiteSemiBold16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
