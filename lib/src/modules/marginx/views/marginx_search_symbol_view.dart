import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/marginx/widgets/marginx_search_instruments_card.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class MarginXSearchSymbolView extends GetView<MarginXController> {
  const MarginXSearchSymbolView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Start Trading'),
        ),
        body: SafeArea(
          bottom: false,
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    visible: !controller.isLoadingStatus,
                    replacement: CommonLoader(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.tradingInstruments.length,
                      itemBuilder: (context, index) {
                        var data = controller.tradingInstruments[index];
                        return MarginXSearchInstrumentsCard(
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
