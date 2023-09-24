import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class StockCard extends GetView<VirtualTradingController> {
  final StockIndexInstrument? stockIndexInstrument;
  final StockIndexDetails? stockIndexInstrumentDetailsList;
  const StockCard({
    Key? key,
    this.stockIndexInstrumentDetailsList,
    this.stockIndexInstrument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Stock Price: ${stockIndexInstrument?.instrumentToken}');
    return Row(
      children: [
        CommonStockInfo(
          label: 'Nifty 50',
          // stockPrice: controller.getStockInstrumentLastPrice(
          //   stockIndexInstrumentDetailsList?.lastPrice?.toInt() ?? 0,
          // ),
          stockLTP: '₹ 183.15',
          stockChange: '(+ 34.42%)',
        ),
        CommonStockInfo(
          label: 'Bank Nifty',
          // stockPrice: controller.getStockInstrumentLastPrice(
          //   stockIndexInstrument?.instrumentToken ?? 0,
          // ),
          stockLTP: '₹ 183.15',
          stockChange: '(+ 34.42%)',
        ),
        CommonStockInfo(
          label: 'Finnifty',
          stockPrice: '₹ 12,500.90',
          stockLTP: '₹ 183.15',
          stockChange: '(+ 34.42%)',
        ),
      ],
    );
  }
}
