import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class TenxWatchlistCard extends StatefulWidget {
  final int index;
  final TenxTradingWatchlist data;

  const TenxWatchlistCard({
    super.key,
    required this.index,
    required this.data,
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
                        TenxWatchlistCardTile(
                          isRightAlign: false,
                          label: 'Contract Date',
                          value: FormatHelper.formatDateByMonth(widget.data.contractDate),
                        ),
                        TenxWatchlistCardTile(
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
                        TenxWatchlistCardTile(
                          isRightAlign: false,
                          label: 'Symbol',
                          value: widget.data.symbol,
                        ),
                        SizedBox(height: 4),
                        TenxWatchlistCardTile(
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
                              builder: (context) => TenxTransactionBottomSheet(
                                type: TransactionType.buy,
                                data: TenxTradingInstrument(
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
                              color: AppColors.success,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              'BUY',
                              style: AppStyles.tsWhiteMedium14,
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
                              builder: (context) => TenxTransactionBottomSheet(
                                type: TransactionType.sell,
                                data: TenxTradingInstrument(
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
                              color: AppColors.danger.shade300,
                            ),
                            child: Text(
                              'SELL',
                              style: AppStyles.tsWhiteMedium14,
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
                              color: AppColors.info,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              'REMOVE',
                              style: AppStyles.tsWhiteMedium14,
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

class TenxWatchlistCardTile extends StatelessWidget {
  final String label;
  final String? value;
  final bool isRightAlign;
  final Color? valueColor;

  const TenxWatchlistCardTile({
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
          label,
          style: Theme.of(context).textTheme.tsMedium14,
        ),
        SizedBox(height: 2),
        Text(
          value ?? '-',
          style: Theme.of(context).textTheme.tsRegular14,
        ),
      ],
    );
  }
}
