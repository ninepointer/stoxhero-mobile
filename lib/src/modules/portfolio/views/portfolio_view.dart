import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class PortfolioView extends GetView<PortfolioController> {
  const PortfolioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTile(label: 'Virtual Trading Portfolio'),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.portfoliList.length,
                itemBuilder: (context, index) => PortfolioCard(
                  portfolio: controller.portfoliList[index],
                ),
              ),
              CommonTile(label: 'TenX Trading Portfolio'),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.portfoliList.length,
                itemBuilder: (context, index) => PortfolioCard(
                  portfolio: controller.portfoliList[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
