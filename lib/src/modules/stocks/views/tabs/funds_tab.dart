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
    num CurrentValue =
        (controller.stockTotalHoldingDetails.value.currentvalue ?? 0) +
            (controller.stockTotalPositionDetails.value.currentvalue ?? 0);

    num InvestedValue = (controller.stockTotalHoldingDetails.value.net ?? 0) +
        (controller.stockTotalPositionDetails.value.holdingnet ?? 0);

    // num TotalOpenPositions = (controller.getOpenPositionCount()) +
    //     (controller.getOpenHoldingCount());

    // num finalpnl = CurrentValue - InvestedValue;

    // num finalROI = (finalpnl * 100) / InvestedValue;

    num MarginUsed = controller.stockfundsmargin.value.totalFund! -
        controller.calculateMargin().round();

    num OPenPositions =
        controller.getOpenPositionCount() + controller.getOpenHoldingCount();

    num PnL = ((controller.stockTotalHoldingDetails.value.pnl ?? 0) +
        (controller.stockTotalPositionDetails.value.pnl ?? 0));

    num brokerage =
        ((controller.stockTotalHoldingDetails.value.brokerage ?? 0) +
            (controller.stockTotalPositionDetails.value.brokerage ?? 0));

    num investmentamount =
        (controller.stockTotalHoldingDetails.value.net ?? 0) +
            (controller.stockTotalPositionDetails.value.holdingnet ?? 0);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 170,
        width: double.infinity,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListView(
          children: [
            FundsCard(
                cardname: "Margin available",
                cardvalue: FormatHelper.formatNumbers(
                  controller.calculateMargin().round().toString(),
                  decimal: 2,
                ),
                index: 0),
            FundsCard(
                cardname: "Margin Used",
                cardvalue: FormatHelper.formatNumbers(MarginUsed, decimal: 2),
                index: 1),
            FundsCard(
                cardname: "Allocated Margin",
                cardvalue: FormatHelper.formatNumbers(
                    controller.stockfundsmargin.value.totalFund.toString()),
                index: 2),
            FundsCard(
                cardname: "Investment Amount",
                cardvalue:
                    FormatHelper.formatNumbers(investmentamount, decimal: 2),
                index: 3),
            FundsCard(
                cardname: "Returns",
                cardvalue:
                    FormatHelper.formatNumbers(PnL - brokerage, decimal: 2),
                index: 4),
            FundsCard(
                cardname: "Unrealised P&L",
                cardvalue: FormatHelper.formatNumbers(PnL, decimal: 2),
                index: 5),
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
  }) : super(key: key);

  final String cardname;
  final String cardvalue;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: index % 2 == 0 ? Colors.white : Colors.grey[200],
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
                  style: AppStyles.tsBlackMedium16, // Uncomment if needed
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  cardvalue,
                  style: TextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
