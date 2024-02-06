import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stoxhero/src/modules/stocks/controllers/stocks_controller.dart';
import '../../../core/core.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    Key? key,
    //required this.invested,
    //  required this.profitloss,
    //  required this.percentage,
    // required this.currentvalue,
    // required this.availablemargin,
    //required this.marginmoney,
    //  required this.marginused,
    // required this.openpositions,
  }) : super(key: key);

  // final String invested;
  // final String profitloss;
  // final String percentage;
  // final String currentvalue;
  // final String availablemargin;
  // final String marginmoney;
  // final String marginused;
  // final String openpositions;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  late StocksTradingController controller;
  final bool _customIcon = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockHoldingsList();
    controller.getStockPositionsList();
  }

  @override
  Widget build(BuildContext context) {
    num InvestedValue = controller.calculateTotalHoldingInvested() +
        controller.calculateTotalPositionInvested();
    // num InvestedValue = (controller.stockTotalHoldingDetails.value.net ?? 0) +
    //     (controller.stockTotalPositionDetails.value.holdingnet ?? 0);

    // num TotalOpenPositions = (controller.getOpenPositionCount()) +
    //     (controller.getOpenHoldingCount());

    // num finalpnl = CurrentValue - InvestedValue;

    // num finalROI = (finalpnl * 100) / InvestedValue;

    num MarginUsed = ((controller.stockfundsmargin.value.totalFund ?? 0) -
            (controller.calculateMargin().round()))
        .abs();

    num OPenPositions =
        controller.getOpenPositionCount() + controller.getOpenHoldingCount();

    num PnL = ((controller.stockTotalHoldingDetails.value.pnl ?? 0) +
        (controller.stockTotalPositionDetails.value.pnl ?? 0));

    num brokerage =
        ((controller.stockTotalHoldingDetails.value.brokerage ?? 0) +
            (controller.stockTotalPositionDetails.value.brokerage ?? 0));
    // (controller
    //                                           .calculateTotalPositionBrokerage() +
    //                                       controller
    //                                           .calculateTotalHoldingBrokerage())

    num availablemarginat0 = ((PnL - brokerage) +
        (controller.stockfundsmargin.value.totalFund ?? 0));
    // num CurrentValue =
    //     (controller.stockTotalHoldingDetails.value.currentvalue ?? 0) +
    //         (controller.stockTotalPositionDetails.value.currentvalue ?? 0);
    // num CurrentValue =
    //     (controller.calculateTotalPortfolioPnl() - brokerage) + InvestedValue;
    // print('paisa brokerage inside ${brokerage}');
    return Obx(
      () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
            ),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 8),
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),

                backgroundColor:
                    Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
                collapsedIconColor: Colors.black,
                //     tilePadding: EdgeInsets.symmetric( horizontal: 10), // Adjust the padding here
                title: Text(
                  "Portfolio Summary",
                  style: AppStyles.tsBlackRegular16,
                ),
                trailing: Icon(
                  _customIcon
                      ? Icons.arrow_drop_down_circle
                      : Icons.arrow_drop_down,
                ),
                children: [
                  ListTile(
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    tileColor: Colors.white,
                    title: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 8, right: 8, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left side
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Net P&L",
                                  style: AppStyles.tsBlackMedium16.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Invested",
                                  style: AppStyles.tsGreyRegular12,
                                ),
                                Text(
                                  FormatHelper.formatNumbers(
                                      controller
                                              .calculateTotalHoldingInvested() +
                                          controller
                                              .calculateTotalPositionInvested(),
                                      decimal: 2),
                                  // FormatHelper.formatNumbers(((controller
                                  //             .stockTotalHoldingDetails
                                  //             .value
                                  //             .net ??
                                  //         0) +
                                  //     (controller.stockTotalPositionDetails.value
                                  //             .net ??
                                  //         0))),
                                  // invested value
                                  // FormatHelper.formatNumbers(
                                  //   (double.parse(controller
                                  //           .stockTotalHoldingDetails.value.net
                                  //           .toString()) +
                                  //       double.parse(controller
                                  //           .stockTotalPositionDetails.value.net
                                  //           .toString())),
                                  // ),
                                  // 'hii',
                                  style: AppStyles.tsBlackMedium14.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Total Margin Money",
                                  style: AppStyles.tsGreyRegular12,
                                ),
                                Text(
                                  // total virtual margin money,
                                  FormatHelper.formatNumbers(controller
                                      .stockfundsmargin.value.totalFund
                                      .toString()),
                                  style: AppStyles.tsBlackMedium14.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Margin Used",
                                  style: AppStyles.tsGreyRegular12,
                                ),
                                Text(
                                  ((controller.calculateTotalPortfolioPnl() -
                                              (controller
                                                      .calculateTotalPositionBrokerage() +
                                                  controller
                                                      .calculateTotalHoldingBrokerage())) <
                                          0)
                                      ? FormatHelper.formatNumbers(
                                          (controller.calculateTotalPortfolioPnl() -
                                                  (controller
                                                          .calculateTotalPositionBrokerage() +
                                                      controller
                                                          .calculateTotalHoldingBrokerage()))
                                              .abs(),
                                          decimal: 2)
                                      : "₹00.00",
                                  // FormatHelper.formatNumbers(MarginUsed,
                                  //     decimal: 2)

                                  // (controller.stockfundsmargin.value.totalFund! -
                                  //         double.parse(FormatHelper.formatNumbers(
                                  //           (controller
                                  //               .calculateMargin()
                                  //               .round()
                                  //               .toString()),
                                  //           decimal: 2,
                                  //         )))
                                  //     .toString(),
                                  //'yo',
                                  style: AppStyles.tsBlackMedium14.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),

                            //right side
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        //currentvalue - invested value
                                        // FormatHelper.formatNumbers((((controller
                                        //                 .stockTotalHoldingDetails
                                        //                 .value
                                        //                 .currentvalue ??
                                        //             0) +
                                        //         (controller
                                        //                 .stockTotalPositionDetails
                                        //                 .value
                                        //                 .currentvalue ??
                                        //             0))) -
                                        //     (((controller.stockTotalHoldingDetails
                                        //                 .value.net ??
                                        //             0) +
                                        //         (controller
                                        //                 .stockTotalPositionDetails
                                        //                 .value
                                        //                 .net ??
                                        //             0)))),

                                        FormatHelper.formatNumbers(
                                            (controller
                                                    .calculateTotalPortfolioPnl() -
                                                ((controller
                                                        .calculateTotalPositionBrokerage() +
                                                    controller
                                                        .calculateTotalHoldingBrokerage()))),
                                            decimal: 2),
                                        style: TextStyle(
                                          color: (double.tryParse((controller
                                                                  .calculateTotalPortfolioPnl() -
                                                              ((controller
                                                                      .calculateTotalPositionBrokerage() +
                                                                  controller
                                                                      .calculateTotalHoldingBrokerage())))
                                                          .toString()) ??
                                                      0) <
                                                  0
                                              ? AppColors.danger
                                              : AppColors.success,
                                          fontFamily: AppTheme.fontFamily,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        )),
                                    // Text(
                                    //   '(${FormatHelper.formatNumbers(finalROI, decimal: 2, showSymbol: false)}%)',
                                    //   style: AppStyles.tsBlackMedium14,
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Current Value",
                                  style: AppStyles.tsGreyRegular12,
                                ),
                                Text(
                                  ((controller.calculateTotalHoldingInvested() +
                                              controller
                                                  .calculateTotalPositionInvested()) ==
                                          0)
                                      ? "₹00.00"
                                      : FormatHelper.formatNumbers(
                                          (controller
                                                  .calculateTotalHoldingCurrentValue() +
                                              controller
                                                  .calculateTotalPositionCurrentValue()),
                                          decimal: 2),
                                  // FormatHelper.formatNumbers(((controller
                                  //             .stockTotalHoldingDetails
                                  //             .value
                                  //             .currentvalue ??
                                  //         0) +
                                  //     (controller.stockTotalPositionDetails.value
                                  //             .currentvalue ??
                                  //         0))),

                                  //'how',
                                  style: AppStyles.tsBlackMedium14.copyWith(
                                      color: ((controller
                                                      .calculateTotalHoldingCurrentValue() +
                                                  controller
                                                      .calculateTotalPositionCurrentValue()) <
                                              (controller
                                                      .calculateTotalHoldingInvested() +
                                                  controller
                                                      .calculateTotalPositionInvested()))
                                          ? AppColors.danger
                                          : AppColors.success),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Available Margin",
                                  style: AppStyles.tsGreyRegular12,
                                ),
                                Text(
                                  ((controller.getOpenPositionCount() +
                                              controller
                                                  .getOpenHoldingCount()) //open Positions
                                          >
                                          0)
                                      ? (FormatHelper.formatNumbers(
                                          controller
                                              .calculateMargin()
                                              .round()
                                              .toString(),
                                          decimal: 2,
                                        ))
                                      : FormatHelper.formatNumbers(
                                          availablemarginat0,
                                          decimal: 2),

//                                   if(OPenPositions>0){

//                                   }
//                                   else{
//                                      FormatHelper.formatNumbers(((PnL - brokerage)+controller
//                                       .stockfundsmargin.value.totalFund),
//                                       decimal: 2),

//                                   }
                                  // widget.availablemargin,

                                  style: AppStyles.tsBlackMedium14.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Open Positions",
                                  style: AppStyles.tsGreyRegular12,
                                ),
                                Text(
                                  // TotalOpenPositions.toString(),
                                  (controller.getOpenPositionCount() +
                                          controller.getOpenHoldingCount())
                                      .toString(),
                                  // ((controller
                                  //         .getOpenPositionCount()
                                  //         .toString()) +
                                  //     (controller
                                  //         .getOpenHoldingCount()
                                  //         .toString())),
                                  style: AppStyles.tsBlackMedium14.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
