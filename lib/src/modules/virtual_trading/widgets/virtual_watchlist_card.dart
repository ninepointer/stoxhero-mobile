import 'package:flutter/material.dart';
import '../../../app/app.dart';

class VirtualWatchListCard extends StatefulWidget {
  final int index;
  final TradingWatchlist tradingWatchlist;
  const VirtualWatchListCard({
    super.key,
    required this.index,
    required this.tradingWatchlist,
  });

  @override
  State<VirtualWatchListCard> createState() => _VirtualWatchListCardState();
}

class _VirtualWatchListCardState extends State<VirtualWatchListCard> {
  late VirtualTradingController controller;

  @override
  void initState() {
    controller = Get.find<VirtualTradingController>();
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
    // log('data: ${widget.tradingWatchlist.toJson()}');
    FocusScope.of(context).unfocus();

    num lastPrice = controller.getInstrumentLastPrice(
      widget.tradingWatchlist.instrumentToken!,
      widget.tradingWatchlist.exchangeInstrumentToken!,
    );
    controller.generateLotsList(type: widget.tradingWatchlist.instrument);
    // log(controller.lotsValueList.toString());
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: VirtualTransactionBottomSheet(
        type: type,
        tradingInstrument: TradingInstrument(
          name: widget.tradingWatchlist.symbol,
          instrumentType: widget.tradingWatchlist.instrument,
          exchange: widget.tradingWatchlist.exchange,
          tradingsymbol: widget.tradingWatchlist.symbol,
          exchangeToken: widget.tradingWatchlist.exchangeInstrumentToken,
          instrumentToken: widget.tradingWatchlist.instrumentToken,
          lastPrice: lastPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.selectedWatchlistIndex.value == widget.index) SizedBox(height: 8),
          CommonCard(
            hasBorder: false,
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.zero,
            onTap: _updateWatchlistIndex,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        VirtualWatchListCardTile(
                          isRightAlign: false,
                          label: 'Contract Date',
                          value: FormatHelper.formatDateByMonth(
                            widget.tradingWatchlist.contractDate,
                          ),
                        ),
                        VirtualWatchListCardTile(
                          isRightAlign: true,
                          label: 'LTP',
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
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        VirtualWatchListCardTile(
                          isRightAlign: false,
                          label: 'Symbol',
                          value: widget.tradingWatchlist.symbol,
                        ),
                        SizedBox(height: 4),
                        VirtualWatchListCardTile(
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
              if (controller.selectedWatchlistIndex.value == widget.index)
                Container(
                  // color: AppColors.grey.shade700,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => openBottomSheet(context, TransactionType.buy),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(.25),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              'BUY',
                              style: AppStyles.tsWhiteMedium14.copyWith(color: AppColors.success),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => openBottomSheet(context, TransactionType.sell),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.danger.withOpacity(.25),
                            ),
                            child: Text(
                              'SELL',
                              style: AppStyles.tsWhiteMedium14.copyWith(color: AppColors.danger),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.removeInstrument(widget.tradingWatchlist.instrumentToken),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.info.withOpacity(.25),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              'REMOVE',
                              style: AppStyles.tsWhiteMedium14.copyWith(color: AppColors.info),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (controller.selectedWatchlistIndex.value == widget.index)
            Column(
              children: [
                // Divider(
                //   thickness: 1,
                //   height: 0,
                // ),
                SizedBox(height: 8),
              ],
            ),
          if (controller.selectedWatchlistIndex.value != widget.index) SizedBox(height: 4),
          // Divider(
          //   thickness: 1,
          //   height: 0,
          // ),
        ],
      ),
    );
  }
}

class VirtualWatchListCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isRightAlign;
  final Color? valueColor;

  const VirtualWatchListCardTile({
    super.key,
    required this.label,
    this.value,
    this.isRightAlign = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '-',
          style: AppStyles.tsGreyMedium12,
        ),
        SizedBox(height: 2),
        Text(
          value ?? '-',
          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
              ),
        ),
      ],
    );
  }
}
