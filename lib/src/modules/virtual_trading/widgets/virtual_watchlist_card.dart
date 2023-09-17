import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class VirtualWatchListCard extends StatefulWidget {
  final int index;
  final VirtualTradingWatchList data;
  const VirtualWatchListCard({
    super.key,
    required this.index,
    required this.data,
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
                          value: FormatHelper.formatDateByMonth(widget.data.contractDate),
                        ),
                        VirtualWatchListCardTile(
                          isRightAlign: true,
                          label: 'LTP',
                          value: controller.getInstrumentLastPrice(
                            widget.data.instrumentToken!,
                            widget.data.exchangeInstrumentToken!,
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
                          value: widget.data.symbol,
                        ),
                        SizedBox(height: 4),
                        VirtualWatchListCardTile(
                          isRightAlign: true,
                          label: 'Changes(%)',
                          value: controller.getInstrumentChanges(
                            widget.data.instrumentToken!,
                            widget.data.exchangeInstrumentToken!,
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
                          onTap: () {
                            log('instrument : ${widget.data.toJson()}');
                            FocusScope.of(context).unfocus();
                            showBottomSheet(
                              context: context,
                              builder: (context) => VirtualTransactionBottomSheet(
                                type: VirtualTransactionType.buy,
                                data: VirtualTradingInstrument(
                                  name: widget.data.symbol,
                                  exchange: widget.data.exchange,
                                  tradingsymbol: widget.data.symbol,
                                  exchangeToken: widget.data.exchangeInstrumentToken,
                                  instrumentToken: widget.data.instrumentToken,
                                ),
                              ),
                            );
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
                            log('instrument : ${widget.data.toJson()}');
                            FocusScope.of(context).unfocus();
                            showBottomSheet(
                              context: context,
                              builder: (context) => VirtualTransactionBottomSheet(
                                type: VirtualTransactionType.sell,
                                data: VirtualTradingInstrument(
                                  name: widget.data.symbol,
                                  exchange: widget.data.exchange,
                                  tradingsymbol: widget.data.symbol,
                                  exchangeToken: widget.data.exchangeInstrumentToken,
                                  instrumentToken: widget.data.instrumentToken,
                                ),
                              ),
                            );
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
