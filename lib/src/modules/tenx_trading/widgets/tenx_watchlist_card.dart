import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class TenxWatchlistCard extends StatefulWidget {
  final int index;
  final TradingWatchlist data;

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
      builder: (context) => VirtualTransactionBottomSheet(
        type: type,
        data: VirtualTradingInstrument(
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
          CommonCard(
            margin: EdgeInsets.all(8).copyWith(top: 8, bottom: 0),
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
                        TenxWatchlistCardTile(
                          isRightAlign: false,
                          label: 'Symbol',
                          value: widget.data.symbol,
                        ),
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
                          // onTap: () {
                          //   log('instrument : ${widget.data.toJson()}');
                          //   FocusScope.of(context).unfocus();
                          //   showBottomSheet(
                          //     context: context,
                          //     builder: (context) => TenxTransactionBottomSheet(
                          //       type: TransactionType.buy,
                          //       data: TenxTradingInstrument(
                          //         name: widget.data.symbol,
                          //         exchange: widget.data.exchange,
                          //         tradingsymbol: widget.data.symbol,
                          //         exchangeToken: widget.data.exchangeInstrumentToken,
                          //         instrumentToken: widget.data.instrumentToken,
                          //       ),
                          //     ),
                          //   );
                          // },
                          onTap: () => openBottomSheet(context, TransactionType.buy),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(.1),
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
                          // onTap: () {
                          //   log('instrument : ${widget.data.toJson()}');
                          //   FocusScope.of(context).unfocus();
                          //   showBottomSheet(
                          //     context: context,
                          //     builder: (context) => TenxTransactionBottomSheet(
                          //       type: TransactionType.sell,
                          //       data: TenxTradingInstrument(
                          //         name: widget.data.symbol,
                          //         exchange: widget.data.exchange,
                          //         tradingsymbol: widget.data.symbol,
                          //         exchangeToken: widget.data.exchangeInstrumentToken,
                          //         instrumentToken: widget.data.instrumentToken,
                          //       ),
                          //     ),
                          //   );
                          // },
                          onTap: () => openBottomSheet(context, TransactionType.sell),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.danger.withOpacity(.1),
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
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.info.withOpacity(.1),
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
          style: Theme.of(context).textTheme.tsGreyRegular12,
        ),
        SizedBox(height: 2),
        Text(
          value ?? '-',
          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                // color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                color: valueColor,
              ),
        ),
      ],
    );
  }
}
