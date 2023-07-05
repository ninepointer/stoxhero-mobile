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
            margin: EdgeInsets.zero,
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
                          isRightAlign: true,
                          label: 'Instrument',
                          value: FormatHelper.formatDateByMonth(widget.data.contractDate),
                          valueColor: AppColors.netural.shade100,
                        ),
                        TenxWatchlistCardTile(
                          label: 'LTP',
                          value: controller.getInstrumentLastPrice(
                            widget.data.instrumentToken!,
                            widget.data.exchangeInstrumentToken!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TenxWatchlistCardTile(
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
            ],
          ),
          if (controller.selectedWatchlistIndex.value == widget.index)
            Container(
              color: AppColors.netural.shade700,
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
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        child: Text(
                          'BUY',
                          style: AppStyles.tsPrimaryMedium14.copyWith(
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
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.danger.withOpacity(0.1),
                        ),
                        child: Text(
                          'SELL',
                          style: AppStyles.tsPrimaryMedium14.copyWith(
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
                          color: AppColors.cyan.withOpacity(0.1),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Text(
                          'REMOVE',
                          style: AppStyles.tsPrimaryMedium14.copyWith(
                            color: AppColors.cyan,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (controller.selectedWatchlistIndex.value == widget.index)
            Column(
              children: [
                Divider(
                  thickness: 1,
                  height: 0,
                ),
                SizedBox(height: 8),
              ],
            ),
          if (controller.selectedWatchlistIndex.value != widget.index)
            Divider(
              thickness: 1,
              height: 0,
            ),
        ],
      ),
    );
  }
}

class TenxWatchlistCardTile extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isRightAlign;
  final Color? valueColor;

  const TenxWatchlistCardTile({
    super.key,
    this.label,
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
          value ?? '-',
          style: AppStyles.tsWhiteRegular14.copyWith(
            color: valueColor ?? AppColors.white,
          ),
        ),
      ],
    );
  }
}
