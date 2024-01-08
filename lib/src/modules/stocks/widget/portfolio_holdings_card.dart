import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stoxhero/src/modules/stocks/widget/stock_transaction_bottom_sheet.dart';

import '../../../app/app.dart';
import '../controllers/stocks_controller.dart';
import 'stock_stoploss_modifyprice_bottomsheet.dart';

class HoldingsCard extends StatefulWidget {
  const HoldingsCard({
    Key? key,
    // required this.title,
    // required this.percentage,
    // required this.shares,
    // required this.currentvalue,
    // required this.invested,
    required this.holding,
  //  required this.imagePath,
  }) : super(key: key);

  // final String title;
  // final String percentage;
  // final String shares;
  // final String currentvalue;
  // final String invested;
  final StockTradingHolding holding;
 // final String imagePath;

  @override
  State<HoldingsCard> createState() => _HoldingsCardState();
}

class _HoldingsCardState extends State<HoldingsCard> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockHoldingsList();
  }

  void openBottomSheet(BuildContext context, TransactionType type) {
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      widget.holding.iId!.instrumentToken!,
      widget.holding.iId!.exchangeInstrumentToken!,
    );
    controller.selectedStringQuantity.value =
        widget.holding.lots?.toString() ?? "0";
    //   controller.generateLotsList(type: position.id?.symbol);
    //   // controller.generateLotsListFoStopLoss(type: position.id?.symbol);
    //   // controller.generateLotsListForStopProfit(type: position.id?.symbol);

    TradingInstrument tradingInstrument = TradingInstrument(
      name: widget.holding.iId?.symbol,
      exchange: widget.holding.iId?.exchange,
      tradingsymbol: widget.holding.iId?.symbol,
      exchangeToken: widget.holding.iId?.exchangeInstrumentToken,
      instrumentToken: widget.holding.iId?.instrumentToken,
      lastPrice: lastPrice,
      lotSize: widget.holding.lots,
    );
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: VirtualTransactionBottomSheet(
        type: type,
        tradingInstrument: tradingInstrument,
        marginRequired: controller.getMarginRequired(type, tradingInstrument),
      ),
    );
  }

  void openModifyBottomSheet(BuildContext context, TransactionType type) async {
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      widget.holding.iId!.instrumentToken!,
      widget.holding.iId!.exchangeInstrumentToken!,
    );
    controller.selectedStringQuantity.value =
        widget.holding.lots?.toString() ?? "0";
    //  await controller
    //     .getVirtualPendingStoplossOrderData(widget.position.iId?.product ?? '');
    // controller.generateLotsList(type: widget.position.iId?.symbol);
    // controller.generateLotsListFoStopLoss(
    //     type: widget.position.iId?.symbol, openLots: widget.position.lots);
    // controller.generateLotsListForStopProfit(
    //     type: widget.position.iId?.symbol, openLots: widget.position.lots);
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: StockStoplossModifyPriceBottomSheet(
        type: type,
        stopLoss: TradingInstrument(
          name: widget.holding.iId?.symbol,
          exchange: widget.holding.iId?.exchange,
          tradingsymbol: widget.holding.iId?.symbol,
          exchangeToken: widget.holding.iId?.exchangeInstrumentToken,
          instrumentToken: widget.holding.iId?.instrumentToken,
          lastPrice: lastPrice,
          lotSize: widget.holding.lots,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                if (widget.holding.lots!.toInt() == 0) {
                  SnackbarHelper.showSnackbar(
                      "You don't have any open position for this symbol.");
                } else if (controller.selectedQuantity.value
                    .toString()
                    .contains('-')) {
                  openModifyBottomSheet(context, TransactionType.sell);
                } else {
                  openModifyBottomSheet(context, TransactionType.buy);
                }
                // Handle edit action
              },
              icon: Icons.edit,
              backgroundColor: Colors.yellow,
              label: 'Modify',
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (contextFromLayoutBuilder, constraints) {
            bool isSlidableOpen = false; // Add this variable

            return GestureDetector(
              child: Container(
                height: 100,
                width: 400,
                padding: EdgeInsets.only(
                  left: 9,
                  right: 9,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              //name of the stock
                              widget.holding.iId?.symbol ?? "",
                              style: AppStyles.tsBlackMedium14,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  'Qty ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  // quantity dalni hai,
                                  widget.holding.lots.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 3.0, // Adjust the radius as needed
                                ),
                                Text(
                                  '  Avg. ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  // averageprice,
                                  FormatHelper.formatNumbers(
                                      widget.holding.lastaverageprice),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Invested',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  FormatHelper.formatNumbers(
                                      widget.holding.amount?.abs().toString(),
                                      decimal: 2),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                          ],
                        ),

                        // Right Side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.holding.lots == 0
                                      ? FormatHelper.formatNumbers(
                                          widget.holding.amount)
                                      : FormatHelper.formatNumbers(
                                          controller.calculateGrossPNL(
                                            widget.holding.amount ?? 0,
                                            widget.holding.lots!.toInt(),
                                            controller.getInstrumentLastPrice(
                                              widget.holding.iId!
                                                  .instrumentToken!,
                                              widget.holding.iId!
                                                  .exchangeInstrumentToken!,
                                            ),
                                          ),
                                        ),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: controller.getValueColor(
                                      widget.holding.lots == 0
                                          ? widget.holding.amount
                                          : controller.calculateGrossPNL(
                                              widget.holding.amount ?? 0,
                                              widget.holding.lots!.toInt(),
                                              controller.getInstrumentLastPrice(
                                                widget.holding.iId!
                                                    .instrumentToken!,
                                                widget.holding.iId!
                                                    .exchangeInstrumentToken!,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Text(
                                  //percentage change ROI,
                                  '(${FormatHelper.formatNumbers(controller.calculateGrossROI(
                                        widget.holding.amount ?? 0,
                                        widget.holding.lots!.toInt(),
                                        controller.getInstrumentLastPrice(
                                          widget.holding.iId!.instrumentToken!,
                                          widget.holding.iId!
                                              .exchangeInstrumentToken!,
                                        ),
                                      ), decimal: 2, showSymbol: false)}%)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: controller.getValueColor(
                                      widget.holding.lots == 0
                                          ? widget.holding.amount
                                          : controller.calculateGrossPNL(
                                              widget.holding.amount ?? 0,
                                              widget.holding.lots!.toInt(),
                                              controller.getInstrumentLastPrice(
                                                widget.holding.iId!
                                                    .instrumentToken!,
                                                widget.holding.iId!
                                                    .exchangeInstrumentToken!,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'LTP',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  FormatHelper.formatNumbers(
                                    controller.getInstrumentLastPrice(
                                      widget.holding.iId!.instrumentToken!,
                                      widget.holding.iId!
                                          .exchangeInstrumentToken!,
                                    ),
                                    decimal: 2,
                                    // showSymbol: false,
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '(${controller.getInstrumentChanges(
                                    widget.holding.iId!.instrumentToken!,
                                    widget
                                        .holding.iId!.exchangeInstrumentToken!,
                                  )}%)',
                                  style: TextStyle(
                                    color: controller.getValueColor(
                                        controller.getInstrumentChanges(
                                      widget.holding.iId!.instrumentToken!,

                                      ///green color hai nhi check krna hai
                                      widget.holding.iId!
                                          .exchangeInstrumentToken!,
                                    )),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Current Value',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  //current value
                                  FormatHelper.formatNumbers(
                                      (widget.holding.lastaverageprice ?? 0) *
                                          (widget.holding.lots?.abs() ?? 0)),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      // Add a Divider widget at the bottom
                      color: Colors.grey[200],
                      thickness: 1.0,
                    ),
                  ],
                ),
              ),
              onTap: () {
                final slidable = Slidable.of(contextFromLayoutBuilder);
                if (isSlidableOpen) {
                  slidable?.close();
                } else {
                  slidable?.openStartActionPane(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                  );
                }
                isSlidableOpen = !isSlidableOpen; // Toggle the state
              },
            );
          },
        ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // Handle delete action

                FocusScope.of(context).unfocus();
                int? lots = widget.holding.lots;
                // generateLotsList(
                //     type: widget.position.iId?.symbol);
                int exitLots = widget.holding.lots!.toInt();

                if (exitLots == 0) {
                  SnackbarHelper.showSnackbar(
                      "You don't have any open position for this symbol.");
                } else {
                  if (exitLots.toString().contains('-')) {
                    if (exitLots < 0) {
                      exitLots = -exitLots;
                    }

                    // if (!lots.contains(exitLots)) {
                    //   lots.add(exitLots);
                    //   lots.sort();
                    // }
                    controller.selectedQuantity.value = exitLots;
                  }

                  // if (exitLots > maxLots) {
                  //   controller.selectedQuantity.value = maxLots;
                  // } else {
                  //   controller.selectedQuantity.value = exitLots;
                  // }

                  // controller.lotsValueList.assignAll(lots);
                  controller.selectedStringQuantity.value =
                      widget.holding.lots?.toString() ?? "0";

                  TradingInstrument trading = TradingInstrument(
                    name: widget.holding.iId?.symbol,
                    exchange: widget.holding.iId?.exchange,
                    tradingsymbol: widget.holding.iId?.symbol,
                    exchangeToken: widget.holding.iId?.exchangeInstrumentToken,
                    instrumentToken: widget.holding.iId?.instrumentToken,
                    lotSize: widget.holding.lots,
                    lastPrice: controller.getInstrumentLastPrice(
                      widget.holding.iId!.instrumentToken!,
                      widget.holding.iId!.exchangeInstrumentToken!,
                    ),
                  );
                  BottomSheetHelper.openBottomSheet(
                    context: context,
                    child: StockTransactionBottomSheet(
                      type: TransactionType.exit,
                      tradingInstrument: trading,
                      marginRequired: controller.getMarginRequired(
                          TransactionType.exit, trading),
                    ),
                  );
                }
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: 'Exit',
            ),
          ],
        ),
      ),
    );
  }
}
