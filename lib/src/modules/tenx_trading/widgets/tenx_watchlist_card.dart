import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class TenxWatchlistCard extends StatefulWidget {
  final int index;
  final TradingWatchlist tradingWatchlist;

  const TenxWatchlistCard({
    super.key,
    required this.index,
    required this.tradingWatchlist,
  });

  @override
  State<TenxWatchlistCard> createState() => _TenxWatchlistCardState();
}

class _TenxWatchlistCardState extends State<TenxWatchlistCard> {
  late TenxTradingController controller;

  @override
  void initState() {
    controller = Get.find<TenxTradingController>();
    super.initState();
  }

  void _updateWatchlistIndex() {
    if (controller.selectedWatchlistIndex.value == widget.index) {
      controller.selectedWatchlistIndex(-1);
    } else {
      controller.selectedWatchlistIndex(widget.index);
    }
  }

  void openBottomSheet(BuildContext context, TransactionType type) {
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      widget.tradingWatchlist.instrumentToken!,
      widget.tradingWatchlist.exchangeInstrumentToken!,
    );
    TradingInstrument tradingInstrument = TradingInstrument(
      name: widget.tradingWatchlist.symbol,
      instrumentType: widget.tradingWatchlist.instrument,
      exchange: widget.tradingWatchlist.exchange,
      tradingsymbol: widget.tradingWatchlist.symbol,
      exchangeToken: widget.tradingWatchlist.exchangeInstrumentToken,
      instrumentToken: widget.tradingWatchlist.instrumentToken,
      lastPrice: lastPrice,
    );
    controller.generateLotsList(type: widget.tradingWatchlist.symbol);
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: TenxTransactionBottomSheet(
        type: type,
        tradingInstrument: tradingInstrument,
        marginRequired: controller.getMarginRequired(type, tradingInstrument),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          CommonCard(
            hasBorder: false,
            margin: EdgeInsets.all(8).copyWith(bottom: 0),
            padding: EdgeInsets.zero,
            onTap: _updateWatchlistIndex,
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
                            widget.tradingWatchlist.contractDate,
                          ),
                        ),
                        TradeCardTile(
                          isRightAlign: true,
                          label: 'LTP (Last Traded Price)',
                          value: FormatHelper.formatNumbers(
                            controller.getInstrumentLastPrice(
                              widget.tradingWatchlist.instrumentToken!,
                              widget.tradingWatchlist.exchangeInstrumentToken!,
                            ),
                          ),
                          valueColor: controller.getValueColor(
                            controller.getInstrumentLastPrice(
                              widget.tradingWatchlist.instrumentToken!,
                              widget.tradingWatchlist.exchangeInstrumentToken!,
                            ),
                          ),
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
                          value: widget.tradingWatchlist.symbol,
                        ),
                        TradeCardTile(
                          hasBottomMargin: false,
                          isRightAlign: true,
                          label: 'Changes(%)',
                          value: controller.getInstrumentChanges(
                            widget.tradingWatchlist.instrumentToken!,
                            widget.tradingWatchlist.exchangeInstrumentToken!,
                          ),
                          valueColor: controller.getValueColor(
                            controller.getInstrumentChanges(
                              widget.tradingWatchlist.instrumentToken!,
                              widget.tradingWatchlist.exchangeInstrumentToken!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openBottomSheet(context, TransactionType.buy),
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
                          style: AppStyles.tsWhiteMedium12.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => openBottomSheet(context, TransactionType.sell),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.danger.withOpacity(.25),
                        ),
                        child: Text(
                          'SELL',
                          style: AppStyles.tsWhiteMedium12.copyWith(
                            color: AppColors.danger,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.removeInstrument(widget.tradingWatchlist.instrumentToken),
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
                          style: AppStyles.tsWhiteMedium12.copyWith(
                            color: AppColors.info,
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
    );
  }
}
