import 'package:flutter/material.dart';

import '../../../app/app.dart';

class VirtualSearchSymbolView extends GetView<VirtualTradingController> {
  const VirtualSearchSymbolView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Start Trading'),
          actions: [
            if (controller.isWatchlistStateLoadingStatus)
              Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            SizedBox(width: 16),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.all(8).copyWith(
                    top: 0,
                  ),
                  child: CommonTextField(
                    controller: controller.searchTextController,
                    padding: EdgeInsets.zero,
                    hintText: 'Search Symbol and start trading',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: controller.searchTextController.clear,
                    ),
                    onChanged: controller.searchInstruments,
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: controller.isInstrumentListLoadingStatus,
                    child: ListViewShimmer(
                      itemCount: 10,
                      shimmerCard: SmallCardShimmer(),
                    ),
                    replacement: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.tradingInstruments.length,
                      padding: EdgeInsets.only(bottom: 100),
                      itemBuilder: (context, index) {
                        var data = controller.tradingInstruments[index];
                        // return VirtualSearchInstrumentsCard(
                        //   tradingInstrument: data,
                        //   isAdded: controller.tradingWatchlistIds.contains(
                        //     data.instrumentToken ?? data.exchangeToken,
                        //   ),
                        // );
                        void openBottomSheet(BuildContext context, TransactionType type) {
                          FocusScope.of(context).unfocus();
                          num lastPrice = controller.getInstrumentLastPrice(
                            data.instrumentToken ?? 0,
                            data.exchangeToken ?? 0,
                          );
                          controller.generateLotsList(type: data.name);
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: VirtualTransactionBottomSheet(
                              type: type,
                              tradingInstrument: TradingInstrument(
                                name: data.tradingsymbol,
                                instrumentType: data.instrumentType,
                                exchange: data.exchange,
                                tradingsymbol: data.tradingsymbol,
                                exchangeToken: data.exchangeToken,
                                instrumentToken: data.instrumentToken,
                                lastPrice: lastPrice,
                              ),
                              marginRequired: controller.getMarginRequired(
                                type,
                                TradingInstrument(
                                  name: data.tradingsymbol,
                                  instrumentType: data.instrumentType,
                                  exchange: data.exchange,
                                  tradingsymbol: data.tradingsymbol,
                                  exchangeToken: data.exchangeToken,
                                  instrumentToken: data.instrumentToken,
                                  lastPrice: lastPrice,
                                ),
                              ),
                            ),
                          );
                        }

                        return TradingInstrumentSearchCard(
                          tradingInstrument: data,
                          isAdded: controller.tradingWatchlistIds.contains(
                            data.instrumentToken ?? data.exchangeToken,
                          ),
                          buyOnTap: () => openBottomSheet(context, TransactionType.buy),
                          sellOnTap: () => openBottomSheet(context, TransactionType.sell),
                          removeOnTap: () => controller.removeInstrument(data.instrumentToken),
                          addOnTap: () => controller.addInstrument(data),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
