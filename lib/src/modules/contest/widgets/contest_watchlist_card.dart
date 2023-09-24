import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/models/response/contest_instrument_list_response.dart';
import 'package:stoxhero/src/data/models/response/contest_watchlist_response.dart';
import 'package:stoxhero/src/modules/contest/contest_index.dart';

import '../../../core/core.dart';

class ContestWatchlistCard extends StatefulWidget {
  final int index;
  final ContestWatchList data;
  const ContestWatchlistCard({
    Key? key,
    required this.index,
    required this.data,
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
    log('data: ${widget.data.toJson()}');
    FocusScope.of(context).unfocus();

    num lastPrice = controller.getInstrumentLastPrice(
      widget.data.instrumentToken!,
      widget.data.exchangeInstrumentToken!,
    );
    controller.generateLotsList(type: widget.data.instrument);
    log(controller.lotsValueList.toString());
    showBottomSheet(
      context: context,
      builder: (context) => ContestTransactionBottomSheet(
        type: type,
        data: ContestInstrument(
          name: widget.data.symbol,
          instrumentType: widget.data.instrument,
          exchange: widget.data.exchange,
          tradingsymbol: widget.data.symbol,
          exchangeToken: widget.data.exchangeInstrumentToken,
          instrumentToken: widget.data.instrumentToken,
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
                        ContestWatchListCardTile(
                          isRightAlign: false,
                          label: 'Contract Date',
                          value: FormatHelper.formatDateByMonth(widget.data.contractDate),
                        ),
                        ContestWatchListCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          value: FormatHelper.formatNumbers(
                            controller
                                .getInstrumentLastPrice(
                                  widget.data.instrumentToken!,
                                  widget.data.exchangeInstrumentToken!,
                                )
                                .toString(),
                          ),
                          valueColor: controller.getValueColor(widget.data.instrumentToken),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ContestWatchListCardTile(
                          isRightAlign: false,
                          label: 'Symbol',
                          value: widget.data.symbol,
                        ),
                        SizedBox(height: 4),
                        ContestWatchListCardTile(
                          isRightAlign: true,
                          label: 'Changes(%)',
                          value: controller.getInstrumentChanges(
                            widget.data.instrumentToken!,
                            widget.data.exchangeInstrumentToken!,
                          ),
                          valueColor: controller.getValueColor(widget.data.instrumentToken),
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
                          onTap: () => controller.removeInstrument(widget.data.instrumentToken),
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
          // if (controller.selectedWatchlistIndex.value != widget.index) SizedBox(height: 4),
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
