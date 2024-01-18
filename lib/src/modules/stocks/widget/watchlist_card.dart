import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stoxhero/src/app/app.dart';

import '../../../core/core.dart';

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
    controller.selectedOrderGroupValue.value = 2;
    controller.selectedProductGroupValue.value = 2;
    // print(tradingInstrument.toJson());
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
    return Container(
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
                padding: EdgeInsets.only(left: 14, right: 14, top: 10),
                color: Get.isDarkMode ? Color(0xFF151F2B) : Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.title,
                                style: AppStyles.tsBlackMedium16.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
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
                              '₹${widget.price}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${widget.percentage}%',
                              style: TextStyle(
                                  color: (double.tryParse(widget.percentage) ??
                                              0) <
                                          0
                                      ? AppColors.danger
                                      : AppColors.success
                                  //
                                  // color: controller.getValueColor(
                                  //     controller.getInstrumentChanges(
                                  //   // widget.holding.iId!.instrumentToken!,
                                  //   widget.equityInstrumentDetail
                                  //           .instrumentToken ??
                                  //       0,

                                  //   ///green color hai nhi check krna hai
                                  //   widget.equityInstrumentDetail
                                  //           .exchangeInstrumentToken ??
                                  //       0,
                                  // )),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey[200]
                          : Colors.transparent,
                      thickness: 1,
                      indent: 15,
                      endIndent: 15,
                    )
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
    );
  }
}
