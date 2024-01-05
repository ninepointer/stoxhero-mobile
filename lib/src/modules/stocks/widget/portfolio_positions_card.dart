import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../app/app.dart';
import '../controllers/stocks_controller.dart';
import 'stock_stoploss_modifyprice_bottomsheet.dart';

class PositionsCard extends StatefulWidget {
  const PositionsCard({
    Key? key,
    // required this.title,
    // required this.percentage,
    // required this.quantity,
    // required this.ltp,
    // required this.averageprice,

    required this.imagePath,
    required this.position,
  }) : super(key: key);

  // final String title;
  // final String percentage;
  // final String quantity;
  // final String ltp;
  // final String averageprice;
  final StockTradingPosition position;
  final String imagePath;

  @override
  State<PositionsCard> createState() => _PositionsCardState();
}

class _PositionsCardState extends State<PositionsCard> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockPositionsList();
  }

  void openBottomSheet(BuildContext context, TransactionType type) {
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      widget.position.iId!.instrumentToken!,
      widget.position.iId!.exchangeInstrumentToken!,
    );
    controller.selectedStringQuantity.value =
        widget.position.lots?.toString() ?? "0";
    // controller.generateLotsList(type: stockTradingPosition.iId?.symbol);
    // controller.generateLotsListFoStopLoss(type: position.id?.symbol);
    // controller.generateLotsListForStopProfit(type: position.id?.symbol);

    TradingInstrument tradingInstrument = TradingInstrument(
      name: widget.position.iId?.symbol,
      exchange: widget.position.iId?.exchange,
      tradingsymbol: widget.position.iId?.symbol,
      exchangeToken: widget.position.iId?.exchangeInstrumentToken,
      instrumentToken: widget.position.iId?.instrumentToken,
      lastPrice: lastPrice,
      lotSize: widget.position.lots,
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
      widget.position.iId!.instrumentToken!,
      widget.position.iId!.exchangeInstrumentToken!,
    );
    controller.selectedStringQuantity.value =
        widget.position.lots?.toString() ?? "0";
    await controller
        .getVirtualPendingStoplossOrderData(widget.position.iId?.product ?? '');
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
          name: widget.position.iId?.symbol,
          exchange: widget.position.iId?.exchange,
          tradingsymbol: widget.position.iId?.symbol,
          exchangeToken: widget.position.iId?.exchangeInstrumentToken,
          instrumentToken: widget.position.iId?.instrumentToken,
          lastPrice: lastPrice,
          lotSize: widget.position.lots,
        ),
      ),
    );
  }

  // void openModifyBottomSheet(BuildContext context, TransactionType type) async {
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
                // Handle edit action

                if (widget.position.lots!.toInt() == 0) {
                  SnackbarHelper.showSnackbar(
                      "You don't have any open position for this symbol.");
                } else if (controller.selectedQuantity.value
                    .toString()
                    .contains('-')) {
                  openModifyBottomSheet(context, TransactionType.sell);
                } else {
                  openModifyBottomSheet(context, TransactionType.buy);
                }
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
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Image.asset(
                                widget.imagePath,
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Text(
                              widget.position.iId?.symbol ?? "",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  // quantity dalni hai,
                                  widget.position.lots.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  ' Quantity',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Right Side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '(Average Price)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  // averageprice,
                                  FormatHelper.formatNumbers(
                                      widget.position.lastaverageprice),
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '(LTP)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  FormatHelper.formatNumbers(
                                    controller.getInstrumentLastPrice(
                                      widget.position.iId!.instrumentToken!,
                                      widget.position.iId!
                                          .exchangeInstrumentToken!,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  widget.position.lots == 0
                                      ? FormatHelper.formatNumbers(
                                          widget.position.amount)
                                      : FormatHelper.formatNumbers(
                                          controller.calculateGrossPNL(
                                            widget.position.amount ?? 0,
                                            widget.position.lots!.toInt(),
                                            controller.getInstrumentLastPrice(
                                              widget.position.iId!
                                                  .instrumentToken!,
                                              widget.position.iId!
                                                  .exchangeInstrumentToken!,
                                            ),
                                          ),
                                        ),
                                  //percentage change,
                                  // controller.getInstrumentChanges(
                                  //   widget.position.iId?.instrumentToken ?? 0,
                                  //   widget.position.iId?.exchangeInstrumentToken ??
                                  //       0,
                                  // ),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: controller.getValueColor(
                                      widget.position.lots == 0
                                          ? widget.position.amount
                                          : controller.calculateGrossPNL(
                                              widget.position.amount ?? 0,
                                              widget.position.lots!.toInt(),
                                              controller.getInstrumentLastPrice(
                                                widget.position.iId!
                                                    .instrumentToken!,
                                                widget.position.iId!
                                                    .exchangeInstrumentToken!,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Text(
                                  //percentage change,
                                  '(${FormatHelper.formatNumbers(controller.calculateGrossROI(
                                        widget.position.amount ?? 0,
                                        widget.position.lots!.toInt(),
                                        controller.getInstrumentLastPrice(
                                          widget.position.iId!.instrumentToken!,
                                          widget.position.iId!
                                              .exchangeInstrumentToken!,
                                        ),
                                      ), decimal: 2)})',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: controller.getValueColor(
                                      widget.position.lots == 0
                                          ? widget.position.amount
                                          : controller.calculateGrossPNL(
                                              widget.position.amount ?? 0,
                                              widget.position.lots!.toInt(),
                                              controller.getInstrumentLastPrice(
                                                widget.position.iId!
                                                    .instrumentToken!,
                                                widget.position.iId!
                                                    .exchangeInstrumentToken!,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
