import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/models/response/contest_watchlist_response.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class MarginXWatchlistCard extends StatefulWidget {
  final int index;
  final ContestWatchList contestWatchList;
  const MarginXWatchlistCard({
    Key? key,
    required this.contestWatchList,
    required this.index,
  }) : super(key: key);

  @override
  _MarginXWatchlistCardState createState() => _MarginXWatchlistCardState();
}

class _MarginXWatchlistCardState extends State<MarginXWatchlistCard> {
  late MarginXController controller;

  @override
  void initState() {
    controller = Get.find<MarginXController>();
    super.initState();
  }

  void _updateWatchlistIndex() {
    if (controller.selectedWatchlistIndex.value == widget.index) {
      controller.selectedWatchlistIndex(-1);
    } else {
      controller.selectedWatchlistIndex(widget.index);
    }
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
                        MarginXWatchListCardTile(
                          isRightAlign: false,
                          label: 'Contract Date',
                          value:
                              FormatHelper.formatDateByMonth(widget.contestWatchList.contractDate),
                        ),
                        MarginXWatchListCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          // value: controller.getInstrumentLastPrice(
                          //   widget.contestWatchList.instrumentToken!,
                          //   widget.contestWatchList.exchangeInstrumentToken!,
                          // ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MarginXWatchListCardTile(
                          isRightAlign: false,
                          label: 'Symbol',
                          value: widget.contestWatchList.symbol,
                        ),
                        SizedBox(height: 4),
                        MarginXWatchListCardTile(
                          isRightAlign: true,
                          label: 'Changes(%)',
                          // value: controller.getInstrumentChanges(
                          //   widget.contestWatchList.instrumentToken!,
                          //   widget.contestWatchList.exchangeInstrumentToken!,
                          // ),
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
                          onTap: () {
                            log('instrument : ${widget.contestWatchList.toJson()}');
                            FocusScope.of(context).unfocus();
                            // showBottomSheet(
                            //   context: context,
                            //   builder: (context) => ContestTransactionBottomSheet(
                            //     type: ContestTransactionType.buy,
                            //     contestWatchList: VirtualTradingInstrument(
                            //       name: widget.contestWatchList.symbol,
                            //       exchange: widget.contestWatchList.exchange,
                            //       tradingsymbol: widget.contestWatchList.symbol,
                            //       exchangeToken: widget.contestWatchList.exchangeInstrumentToken,
                            //       instrumentToken: widget.contestWatchList.instrumentToken,
                            //     ),
                            //   ),
                            // );
                          },
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
                          onTap: () {
                            log('instrument : ${widget.contestWatchList.toJson()}');
                            FocusScope.of(context).unfocus();
                            // showBottomSheet(
                            //   context: context,
                            //   builder: (context) => VirtualTransactionBottomSheet(
                            //     type: VirtualTransactionType.sell,
                            //     data: VirtualTradingInstrument(
                            //       name: widget.data.symbol,
                            //       exchange: widget.data.exchange,
                            //       tradingsymbol: widget.data.symbol,
                            //       exchangeToken: widget.data.exchangeInstrumentToken,
                            //       instrumentToken: widget.data.instrumentToken,
                            //     ),
                            //   ),
                            // );
                          },
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
                          // onTap: () => controller.removeInstrument(widget.data.instrumentToken),
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
