// import 'dart:developer';

// import 'package:flutter/material.dart';
// import '../../app/app.dart';

// class CommonTradingWatchlistCard extends StatefulWidget {
//   final int index;
//   final TradingWatchlist tradingWatchlist;
//   final TradingInstrument? tradingInstrument;
//   const CommonTradingWatchlistCard({
//     Key? key,
//     required this.tradingWatchlist,
//     required this.index,
//     this.tradingInstrument,
//   }) : super(key: key);

//   @override
//   State<CommonTradingWatchlistCard> createState() => _CommonTradingWatchlistCardState();
// }

// class _CommonTradingWatchlistCardState extends State<CommonTradingWatchlistCard> {
//   final selectedWatchlistIndex = RxInt(-1);

//   void _updateWatchlistIndex() {
//     if (selectedWatchlistIndex.value == widget.index) {
//       selectedWatchlistIndex(-1);
//     } else {
//       selectedWatchlistIndex(widget.index);
//     }
//   }

//   void openBottomSheet(BuildContext context, TransactionType type) {
//     log('tradingInstrument: ${widget.tradingInstrument?.toJson()}');
//     FocusScope.of(context).unfocus();

//     // num lastPrice = controller.getInstrumentLastPrice(
//     //   widget.tradingInstrument?.instrumentToken!,
//     //   widget.tradingInstrument?.exchangeInstrumentToken!,
//     // );
//     // generateLotsList(type: widget.tradingInstrument?.instrumentToken);
//     // log(controller.lotsValueList.toString());
//     showBottomSheet(
//       context: context,
//       builder: (context) => VirtualTransactionBottomSheet(
//         type: type,
//         tradingInstrument: TradingInstrument(
//           name: widget.tradingInstrument?.tradingsymbol,
//           instrumentType: widget.tradingInstrument?.instrumentType,
//           exchange: widget.tradingInstrument?.exchange,
//           tradingsymbol: widget.tradingInstrument?.tradingsymbol,
//           exchangeToken: widget.tradingInstrument?.exchangeToken,
//           instrumentToken: widget.tradingInstrument?.instrumentToken,
//           lastPrice: widget.tradingInstrument?.lastPrice,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         children: [
//           CommonCard(
//             margin: EdgeInsets.all(8).copyWith(top: 8, bottom: 0),
//             padding: EdgeInsets.zero,
//             onTap: _updateWatchlistIndex,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CommonWatchlistCardTile(
//                           isRightAlign: false,
//                           label: 'Contract Date',
//                           value:
//                               FormatHelper.formatDateByMonth(widget.tradingWatchlist.contractDate),
//                         ),
//                         CommonWatchlistCardTile(
//                           isRightAlign: true,
//                           label: 'LTP',
//                           // value: FormatHelper.formatNumbers(
//                           //   controller
//                           //       .getInstrumentLastPrice(
//                           //         widget.tradingWatchlist.instrumentToken!,
//                           //         widget.tradingWatchlist.exchangeInstrumentToken!,
//                           //       )
//                           //       .toString(),
//                           // ),
//                           // valueColor: controller.getValueColor(
//                           //   widget.tradingWatchlist.instrumentToken,
//                           // ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 4),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CommonWatchlistCardTile(
//                           isRightAlign: false,
//                           label: 'Symbol',
//                           value: widget.tradingWatchlist.symbol,
//                         ),
//                         CommonWatchlistCardTile(
//                           isRightAlign: true,
//                           label: 'Changes(%)',
//                           // value: controller.getInstrumentChanges(
//                           //   widget.tradingWatchlist.instrumentToken!,
//                           //   widget.tradingWatchlist.exchangeInstrumentToken!,
//                           // ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               if (selectedWatchlistIndex.value == widget.index)
//                 Container(
//                   // color: AppColors.grey.shade700,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           // onTap: () {
//                           //   log('instrument : ${tradingWatchlist.toJson()}');
//                           //   FocusScope.of(context).unfocus();
//                           //   showBottomSheet(
//                           //     context: context,
//                           //     builder: (context) => TenxTransactionBottomSheet(
//                           //       type: TransactionType.buy,
//                           //tradingWatchlist. TenxTradingInstrument(
//                           //         name: tradingWatchlist.symbol,
//                           //         exchange: tradingWatchlist.exchange,
//                           //         tradingsymbol: tradingWatchlist.symbol,
//                           //         exchangeToken: tradingWatchlist.exchangeInstrumentToken,
//                           //         instrumentToken: tradingWatchlist.instrumentToken,
//                           //       ),
//                           //     ),
//                           //   );
//                           // },
//                           onTap: () => openBottomSheet(context, TransactionType.buy),
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: AppColors.success.withOpacity(.25),
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               'BUY',
//                               style: AppStyles.tsWhiteMedium14.copyWith(
//                                 color: AppColors.success,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           // onTap: () {
//                           //   log('instrument : ${tradingWatchlist.toJson()}');
//                           //   FocusScope.of(context).unfocus();
//                           //   showBottomSheet(
//                           //     context: context,
//                           //     builder: (context) => TenxTransactionBottomSheet(
//                           //       type: TransactionType.sell,
//                           //tradingWatchlist. TenxTradingInstrument(
//                           //         name: tradingWatchlist.symbol,
//                           //         exchange: tradingWatchlist.exchange,
//                           //         tradingsymbol: tradingWatchlist.symbol,
//                           //         exchangeToken: tradingWatchlist.exchangeInstrumentToken,
//                           //         instrumentToken: tradingWatchlist.instrumentToken,
//                           //       ),
//                           //     ),
//                           //   );
//                           // },
//                           onTap: () => openBottomSheet(context, TransactionType.sell),
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: AppColors.danger.withOpacity(.25),
//                             ),
//                             child: Text(
//                               'SELL',
//                               style: AppStyles.tsWhiteMedium14.copyWith(
//                                 color: AppColors.danger,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           // onTap: () =>
//                           //     controller.removeInstrument(widget.tradingWatchlist.instrumentToken),
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: AppColors.info.withOpacity(.25),
//                               borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               'REMOVE',
//                               style: AppStyles.tsWhiteMedium14.copyWith(
//                                 color: AppColors.info,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//           if (selectedWatchlistIndex.value == widget.index)
//             Column(
//               children: [
//                 // Divider(
//                 //   thickness: 1,
//                 //   height: 0,
//                 // ),
//                 SizedBox(height: 8),
//               ],
//             ),
//           if (selectedWatchlistIndex.value != widget.index) SizedBox(height: 4),
//           // Divider(
//           //   thickness: 1,
//           //   height: 0,
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class CommonWatchlistCardTile extends StatelessWidget {
//   final String label;
//   final String? value;
//   final bool isRightAlign;
//   final Color? valueColor;

//   const CommonWatchlistCardTile({
//     super.key,
//     required this.label,
//     this.value,
//     this.isRightAlign = false,
//     this.valueColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: Theme.of(context).textTheme.tsGreyRegular12,
//         ),
//         SizedBox(height: 2),
//         Text(
//           value ?? '-',
//           style: Theme.of(context).textTheme.tsMedium14.copyWith(
//                 // color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
//                 color: valueColor,
//               ),
//         ),
//       ],
//     );
//   }
// }
