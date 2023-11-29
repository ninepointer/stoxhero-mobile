import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ContestSearchSymbolView extends GetView<ContestController> {
  const ContestSearchSymbolView({Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.all(8).copyWith(top: 0),
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
                SizedBox(height: 8),
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
                      itemBuilder: (context, index) {
                        var data = controller.tradingInstruments[index];
                        void openBottomSheet(
                            BuildContext context, TransactionType type) {
                          controller.addInstrument(data);
                          FocusScope.of(context).unfocus();
                          num lastPrice = controller.getInstrumentLastPrice(
                            data.instrumentToken ?? 0,
                            data.exchangeToken ?? 0,
                          );
                          controller.generateLotsList(type: data.name);
                          var tradingIntrument = TradingInstrument(
                            name: data.tradingsymbol,
                            instrumentType: data.instrumentType,
                            exchange: data.exchange,
                            tradingsymbol: data.tradingsymbol,
                            exchangeToken: data.exchangeToken,
                            instrumentToken: data.instrumentToken,
                            lastPrice: lastPrice,
                          );
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: ContestTransactionBottomSheet(
                              type: type,
                              tradingInstrument: tradingIntrument,
                              marginRequired: controller.getMarginRequired(
                                  type, tradingIntrument),
                            ),
                          );
                        }

                        return TradingInstrumentSearchCard(
                          tradingInstrument: data,
                          isAdded: controller.tradingWatchlistIds.contains(
                            data.instrumentToken ?? data.exchangeToken,
                          ),
                          buyOnTap: () =>
                              openBottomSheet(context, TransactionType.buy),
                          sellOnTap: () =>
                              openBottomSheet(context, TransactionType.sell),
                          removeOnTap: () =>
                              controller.removeInstrument(data.instrumentToken),
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
