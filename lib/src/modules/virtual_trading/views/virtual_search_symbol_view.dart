import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class VirtualSearchSymbolView extends GetView<VirtualTradingController> {
  const VirtualSearchSymbolView({Key? key}) : super(key: key);

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
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.virtualInstruments.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        var data = controller.virtualInstruments[index];
                        return VirtualSearchInstrumentsCard(
                          data: data,
                          isAdded: controller.virtualInstruments.contains(
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
