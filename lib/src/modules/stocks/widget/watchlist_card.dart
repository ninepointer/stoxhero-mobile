import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:stoxhero/src/modules/stocks/widget/stock_transaction_bottom_sheet.dart';

import '../../../core/core.dart';
import '../controllers/stocks_controller.dart';

class WatchlistCard extends StatefulWidget {
  const WatchlistCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.percentage,
    required this.equityInstrumentDetail,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final String price;
  final String percentage;
  final EquityInstrumentDetail equityInstrumentDetail;

  @override
  State<WatchlistCard> createState() => _WatchlistCardState();
}

class _WatchlistCardState extends State<WatchlistCard> {
  late StocksTradingController controller;
  void openBottomSheet(BuildContext context, TransactionType type) {
    FocusScope.of(context).unfocus();

    TradingInstrument tradingInstrument = TradingInstrument(
      exchange: widget.equityInstrumentDetail.exchange,
      tradingsymbol: widget.equityInstrumentDetail.symbol,
      exchangeToken: widget.equityInstrumentDetail.exchangeInstrumentToken,
      instrumentToken: widget.equityInstrumentDetail.instrumentToken,
      name: widget.equityInstrumentDetail.symbol,
      // instrumentType: widget.tradingWatchlist.instrument,
      // lastPrice: lastPrice,
    );
    print(tradingInstrument.toJson());
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: StockTransactionBottomSheet(
          type: type,
          tradingInstrument: tradingInstrument,
          marginRequired:
              controller.getMarginRequired(type, tradingInstrument)),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Slidable(
          startActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  openBottomSheet(context, TransactionType.buy);
                  print('buy');
                },
                icon: Icons.shopping_cart,
                backgroundColor: Colors.green,
                label: 'BUY',
              ),
              SlidableAction(
                onPressed: (context) {
                  openBottomSheet(context, TransactionType.sell);
                  print('sell');
                },
                icon: Icons.shopping_cart,
                backgroundColor: Colors.red,
                label: 'SELL',
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (contextFromLayoutBuilder, constraints) {
              bool isSlidableOpen = false; // Add this variable
              // ...

              return GestureDetector(
                child: Container(
                  height: 75,
                  width: 400,
                  padding:
                      EdgeInsets.only(left: 9, right: 9, top: 5, bottom: 5),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Image.asset(
                              widget.imagePath,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.price,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                widget.percentage,
                                style: TextStyle(
                                  color: Colors.green,
                                ),
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
                  controller.removeInstrument(
                      widget.equityInstrumentDetail.instrumentToken);
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
                label: 'DELETE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
