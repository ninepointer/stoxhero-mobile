import 'package:flutter/material.dart';
import '../../app/app.dart';

class TradingWatchlistCard extends StatelessWidget {
  final TradingWatchlist tradingWatchlist;
  const TradingWatchlistCard({
    Key? key,
    required this.tradingWatchlist,
  }) : super(key: key);

  // void openBottomSheet(BuildContext context, TransactionType type) {
  //   FocusScope.of(context).unfocus();

  //   num lastPrice = controller.getInstrumentLastPrice(
  //     tradingWatchlist.instrumentToken!,
  //     tradingWatchlist.exchangeInstrumentToken!,
  //   );
  //   controller.generateLotsList(type: tradingWatchlist.symbol);
  //   TradingInstrument tradingInstrument = TradingInstrument(
  //     name: tradingWatchlist.symbol,
  //     instrumentType: tradingWatchlist.instrument,
  //     exchange: tradingWatchlist.exchange,
  //     tradingsymbol: tradingWatchlist.symbol,
  //     exchangeToken: tradingWatchlist.exchangeInstrumentToken,
  //     instrumentToken: tradingWatchlist.instrumentToken,
  //     lastPrice: lastPrice,
  //   );
  //   BottomSheetHelper.openBottomSheet(
  //     context: context,
  //     child: VirtualTransactionBottomSheet(
  //       type: type,
  //       tradingInstrument: tradingInstrument,
  //       marginRequired: controller.getMarginRequired(
  //         type,
  //         tradingInstrument,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          CommonCard(
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
                          isRightAlign: false,
                          label: 'Contract Expiry Date',
                          value: FormatHelper.formatDateByMonth(
                            tradingWatchlist.contractDate,
                          ),
                        ),
                        TradeCardTile(
                          isRightAlign: true,
                          label: 'LTP (Last Traded Price)',
                          // value: FormatHelper.formatNumbers(
                          //   // controller.getInstrumentLastPrice(
                          //   //   tradingWatchlist.instrumentToken!,
                          //   //   tradingWatchlist.exchangeInstrumentToken!,
                          //   // ),
                          // ),
                          // valueColor: controller.getValueColor(
                          //   controller.getInstrumentLastPrice(
                          //     widget.tradingWatchlist.instrumentToken!,
                          //     widget.tradingWatchlist.exchangeInstrumentToken!,
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TradeCardTile(
                          hasBottomMargin: false,
                          isRightAlign: false,
                          label: 'Symbol',
                          value: tradingWatchlist.symbol,
                        ),
                        TradeCardTile(
                          hasBottomMargin: false,
                          isRightAlign: true,
                          label: 'Changes(%)',
                          // value: controller.getInstrumentChanges(
                          //   widget.tradingWatchlist.instrumentToken!,
                          //   widget.tradingWatchlist.exchangeInstrumentToken!,
                          // ),
                          // valueColor: controller.getValueColor(
                          //   controller.getInstrumentChanges(
                          //     widget.tradingWatchlist.instrumentToken!,
                          //     widget.tradingWatchlist.exchangeInstrumentToken!,
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        // onTap: () => openBottomSheet(context, TransactionType.buy),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(.25),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            'BUY',
                            style: AppStyles.tsWhiteMedium12.copyWith(color: AppColors.success),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        // onTap: () => openBottomSheet(context, TransactionType.sell),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withOpacity(.25),
                          ),
                          child: Text(
                            'SELL',
                            style: AppStyles.tsWhiteMedium12.copyWith(color: AppColors.danger),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        // onTap: () => controller.removeInstrument(tradingWatchlist.instrumentToken),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.info.withOpacity(.25),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            'REMOVE',
                            style: AppStyles.tsWhiteMedium12.copyWith(color: AppColors.info),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
