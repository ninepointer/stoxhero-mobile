import 'package:flutter/material.dart';

import '../../../app/app.dart';
import '../controllers/stocks_controller.dart';

class StockInstrumentSearchCard extends StatefulWidget {
  const StockInstrumentSearchCard({
    super.key,
    required this.stockname,
    required this.lastPrice,
    required this.percentageChange,
    required this.buyOnTap,
    // required this.isAdded
  });

  // final bool isAdded;
  final String stockname;
  final String lastPrice;
  final String percentageChange;
  final VoidCallback buyOnTap;

  @override
  State<StockInstrumentSearchCard> createState() =>
      _StockInstrumentSearchCardState();
}

class _StockInstrumentSearchCardState extends State<StockInstrumentSearchCard> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  widget.stockname,
                  style: AppStyles.tsBlackRegular16,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          FormatHelper.formatNumbers(widget.lastPrice,
                              decimal: 2),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(${widget.percentageChange}%)',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        widget.buyOnTap;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),
          ],
        ),
      ),
    );
  }
}
