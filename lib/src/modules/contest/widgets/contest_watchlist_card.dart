import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class ContestWatchlistCard extends StatefulWidget {
  final int index;
  final ContestWatchList contestWatchlist;
  final String? contestId;
  const ContestWatchlistCard({
    Key? key,
    required this.index,
    required this.contestWatchlist,
    this.contestId,
  }) : super(key: key);

  @override
  _ContestWatchlistCardState createState() => _ContestWatchlistCardState();
}

class _ContestWatchlistCardState extends State<ContestWatchlistCard> {
  late ContestController controller;

  @override
  void initState() {
    controller = Get.find<ContestController>();
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
    log('data: ${widget.contestWatchlist.toJson()}');
    FocusScope.of(context).unfocus();

    num lastPrice = controller.getInstrumentLastPrice(
      widget.contestWatchlist.instrumentToken!,
      widget.contestWatchlist.exchangeInstrumentToken!,
    );
    controller.generateLotsList(type: widget.contestWatchlist.instrument);
    log(controller.lotsValueList.toString());
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: ContestTransactionBottomSheet(
        type: type,
        contestId: widget.contestWatchlist.sId,
        tradingInstrument: TradingInstrument(
          name: widget.contestWatchlist.symbol,
          instrumentType: widget.contestWatchlist.instrument,
          exchange: widget.contestWatchlist.exchange,
          tradingsymbol: widget.contestWatchlist.symbol,
          exchangeToken: widget.contestWatchlist.exchangeInstrumentToken,
          instrumentToken: widget.contestWatchlist.instrumentToken,
          lastPrice: lastPrice,
          id: widget.contestWatchlist.sId,
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
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        ContestWatchListCardTile(
                          isRightAlign: false,
                          label: 'Contract Date',
                          value: FormatHelper.formatDateByMonth(widget.contestWatchlist.contractDate),
                        ),
                        ContestWatchListCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          value: FormatHelper.formatNumbers(
                            controller
                                .getInstrumentLastPrice(
                                  widget.contestWatchlist.instrumentToken!,
                                  widget.contestWatchlist.exchangeInstrumentToken!,
                                )
                                .toString(),
                          ),
                          valueColor: controller.getValueColor(widget.contestWatchlist.instrumentToken),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ContestWatchListCardTile(
                          isRightAlign: false,
                          label: 'Symbol',
                          value: widget.contestWatchlist.symbol,
                        ),
                        SizedBox(height: 2),
                        ContestWatchListCardTile(
                          isRightAlign: true,
                          label: 'Changes(%)',
                          value: controller.getInstrumentChanges(
                            widget.contestWatchlist.instrumentToken!,
                            widget.contestWatchlist.exchangeInstrumentToken!,
                          ),
                          valueColor: controller.getValueColor(widget.contestWatchlist.instrumentToken),
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
                              style: AppStyles.tsWhiteMedium14.copyWith(
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
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.danger.withOpacity(.25),
                            ),
                            child: Text(
                              'SELL',
                              style: AppStyles.tsWhiteMedium14.copyWith(
                                color: AppColors.danger,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.removeInstrument(widget.contestWatchlist.instrumentToken),
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
                              style: AppStyles.tsWhiteMedium14.copyWith(
                                color: AppColors.info,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          // if (controller.selectedWatchlistIndex.value == widget.index)
          //   Column(
          //     children: [
          //       // Divider(
          //       //   thickness: 1,
          //       //   height: 0,
          //       // ),
          //       SizedBox(height: 8),
          //     ],
          //   ),
          // if (controller.selectedWatchlistIndex.value != widget.index) SizedBox(height: 2),
          // // Divider(
          // //   thickness: 1,
          // //   height: 0,
          // // ),
        ],
      ),
    );
  }
}

class ContestWatchListCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isRightAlign;
  final Color? valueColor;

  const ContestWatchListCardTile({
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
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
