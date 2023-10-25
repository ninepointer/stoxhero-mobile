import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

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
                        return ContestSearchInstrumentsCard(
                          tradingInstrument: data,
                          isAdded: controller.tradingWatchlistIds.contains(
                            data.instrumentToken ?? data.exchangeToken,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
