import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';
import '../../controllers/stocks_controller.dart';

class Funds extends StatefulWidget {
  const Funds({
    Key? key,
    // required this.marginavailable,
    // required this.usedmargin,
    // required this.allocatedmargin,
    // required this.investmentamount,
    // required this.returns,
    // required this.unrealisedPL,
    // required this.returnpercentage,
  }) : super(key: key);

  // final String marginavailable;
  // final String usedmargin;
  // final String allocatedmargin;
  // final String investmentamount;
  // final String returns;
  // final String unrealisedPL;
  //final String returnpercentage;

  @override
  State<Funds> createState() => _FundsState();
}

class _FundsState extends State<Funds> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockHoldingsList();
    controller.getStockPositionsList();
  }

  @override
  Widget build(BuildContext context) {
    // num CurrentValue =

    //     (controller.stockTotalHoldingDetails.value.currentvalue ?? 0) +
    //         (controller.stockTotalPositionDetails.value.currentvalue ?? 0);

    // num InvestedValue = (controller.stockTotalHoldingDetails.value.net ?? 0) +
    //     (controller.stockTotalPositionDetails.value.holdingnet ?? 0);

    // num TotalOpenPositions = (controller.getOpenPositionCount()) +
    //     (controller.getOpenHoldingCount());

    // num finalpnl = CurrentValue - InvestedValue;

    // num finalROI = (finalpnl * 100) / InvestedValue;

    // num MarginUsed = controller.stockfundsmargin.value.totalFund! -
    //     controller.calculateMargin().round();

    // num? totalFund = controller.stockfundsmargin.value.totalFund;
    num totalFund = controller.stockfundsmargin.value.totalFund ?? 0;

    // num MarginUsed = totalFund != null
    //     ? (totalFund - controller.calculateMargin().round())
    //     : 0;
    num MarginUsed = ((controller.stockfundsmargin.value.totalFund ?? 0) -
            (controller.calculateMargin().round()))
        .abs();

    num OPenPositions =
        controller.getOpenPositionCount() + controller.getOpenHoldingCount();

    // num PnL = ((controller.stockTotalHoldingDetails.value.pnl ?? 0) +
    //     (controller.stockTotalPositionDetails.value.pnl ?? 0));

    num brokerage = (controller.calculateTotalPositionBrokerage() +
        controller.calculateTotalHoldingBrokerage());

    num InvestedValue = controller.calculateTotalHoldingInvested() +
        controller.calculateTotalPositionInvested();

    num availablemarginat0 =
        ((controller.calculateTotalPortfolioPnl() - brokerage) +
            (controller.stockfundsmargin.value.totalFund ?? 0));

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 170,
        width: double.infinity,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
          borderRadius: BorderRadius.circular(25.0),
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
        child: ListView(
          children: [
            FundsCard(
                cardname: "Profit & Loss",
                cardvalue: FormatHelper.formatNumbers(
                    controller.calculateTotalPortfolioPnl() -
                        (controller.calculateTotalPositionBrokerage() +
                            controller.calculateTotalHoldingBrokerage()),
                    decimal: 2),
                style: TextStyle(
                  color: (double.tryParse((controller
                                          .calculateTotalPortfolioPnl() -
                                      (controller
                                              .calculateTotalPositionBrokerage() +
                                          controller
                                              .calculateTotalHoldingBrokerage()))
                                  .toString()) ??
                              0) <
                          0
                      ? AppColors.danger
                      : AppColors.success,
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                index: 1),
            SizedBox(
              height: 5,
            ),
            FundsCard(
              cardname: "Unrealised P&L",
              cardvalue: FormatHelper.formatNumbers(
                  controller.calculateTotalPortfolioPnl() < 0
                      ? 0
                      : controller.calculateTotalPortfolioPnl(),
                  decimal: 2),
              style: TextStyle(
                color: AppColors.success,
                fontFamily: AppTheme.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              index: 2,
            ),
            SizedBox(
              height: 5,
            ),
            FundsCard(
                style: AppStyles.tsBlackMedium14.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
                cardname: "Margin Used",
                cardvalue: ((controller.calculateTotalPortfolioPnl() -
                            (controller.calculateTotalPositionBrokerage() +
                                controller.calculateTotalHoldingBrokerage())) <
                        0)
                    ? FormatHelper.formatNumbers(
                        (controller.calculateTotalPortfolioPnl() -
                                (controller.calculateTotalPositionBrokerage() +
                                    controller
                                        .calculateTotalHoldingBrokerage()))
                            .abs(),
                        decimal: 2)
                    : "₹00.00",
                //  FormatHelper.formatNumbers(MarginUsed.abs(), decimal: 2),
                index: 3),
            SizedBox(
              height: 5,
            ),
            FundsCard(
                style: AppStyles.tsBlackMedium14.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
                cardname: "Margin available",
                cardvalue: ( (controller.getOpenPositionCount() + controller.getOpenHoldingCount())//open Positions
                > 0)
                    ? (FormatHelper.formatNumbers(
                        controller.calculateMargin().round().toString(),
                        decimal: 2,
                      ))
                    : FormatHelper.formatNumbers(availablemarginat0,
                        decimal: 2),
                // FormatHelper.formatNumbers(
                //   controller.calculateMargin().round().toString(),
                //   decimal: 2,
                // ),
                index: 4),
            SizedBox(
              height: 5,
            ),

            FundsCard(
                style: AppStyles.tsBlackMedium14.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
                cardname: "Allocated Margin",
                cardvalue: FormatHelper.formatNumbers(
                    controller.stockfundsmargin.value.totalFund.toString()),
                index: 5),
            SizedBox(
              height: 5,
            ),
            FundsCard(
                style: AppStyles.tsBlackMedium14.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
                cardname: "Investment Amount",
                cardvalue:
                    FormatHelper.formatNumbers(InvestedValue.abs(), decimal: 2),
                index: 6),
            SizedBox(
              height: 5,
            ),

            FundsCard(
              cardname: "Brokerage",
              cardvalue: FormatHelper.formatNumbers(brokerage),
              style: AppStyles.tsBlackMedium14.copyWith(
                  color: Get.isDarkMode ? Colors.white : Colors.black),
              index: 7,
            ),

            // FundsCard(
            //     cardname: "Return Percentage",
            //     cardvalue: widget.returnpercentage,
            //     index: 6),
            // Add more FundsCard widgets as needed
          ],
        ),
      ),
    );
  }
}

class FundsCard extends StatelessWidget {
  const FundsCard({
    Key? key,
    required this.cardname,
    required this.cardvalue,
    required this.index,
    required this.style,
  }) : super(key: key);

  final String cardname;
  final String cardvalue;
  final int index;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Get.isDarkMode
          ? Color(0xFF151F2B)
          : (index % 2 == 0 ? Colors.white : Colors.grey[200]),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardname,
                  style: AppStyles.tsBlackMedium16.copyWith(
                      color: Get.isDarkMode
                          ? Colors.white
                          : Colors.black), // Uncomment if needed
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  cardvalue,
                  style: style,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
