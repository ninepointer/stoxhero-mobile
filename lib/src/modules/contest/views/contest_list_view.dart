import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/core.dart';
import '../contest_index.dart';

class ContestListView extends GetView<ContestController> {
  const ContestListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contest List'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommonSegmentedControl(
                    segments: {
                      0: 'Upcoming',
                      1: 'Live',
                      2: 'Completed',
                    },
                    selectedSegment: controller.segmentedControlValue.value,
                    onValueChanged: controller.handleSegmentChange,
                  ),
                  if (controller.segmentedControlValue.value == 0) ...[
                    if (controller.premiumContestList.isEmpty && controller.freeContestList.isEmpty)
                      NoDataFound(
                        label: 'No Upcoming Contest!',
                      ),
                    if (controller.premiumContestList.isNotEmpty)
                      CommonTile(label: 'Premium Contest\'s'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.premiumContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var upComing = controller.premiumContestList[index];
                        return UpComingContestCard(
                          contestName: upComing.contestName,
                          isNifty: upComing.isNifty,
                          isBankNifty: upComing.isBankNifty,
                          isFinNifty: upComing.isFinNifty,
                          contestExpiry: upComing.contestExpiry,
                          contestStatus: upComing.contestStatus,
                          maxParticipants: upComing.maxParticipants,
                          contestStartTime: upComing.contestStartTime,
                          contestEndTime: upComing.contestEndTime,
                          payoutPercentage: upComing.payoutPercentage,
                          entryFee: upComing.entryFee,
                          portfolio: upComing.portfolio,
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    if (controller.freeContestList.isNotEmpty) CommonTile(label: 'Free Contest\'s'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.freeContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var upComing = controller.freeContestList[index];
                        return UpComingContestCard(
                          contestName: upComing.contestName,
                          isNifty: upComing.isNifty,
                          isBankNifty: upComing.isBankNifty,
                          isFinNifty: upComing.isFinNifty,
                          contestExpiry: upComing.contestExpiry,
                          contestStatus: upComing.contestStatus,
                          maxParticipants: upComing.maxParticipants,
                          contestStartTime: upComing.contestStartTime,
                          contestEndTime: upComing.contestEndTime,
                          payoutPercentage: upComing.payoutPercentage,
                          entryFee: upComing.entryFee,
                          portfolio: upComing.portfolio,
                        );
                      },
                    )
                  ] else if (controller.segmentedControlValue.value == 1) ...[
                    if (controller.liveContestList.isEmpty)
                      NoDataFound(
                        label: 'No Live Contest!',
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.liveContestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var live = controller.liveContestList[index];
                          return LiveContestCard(
                            contestName: live.contestName,
                            isNifty: live.isNifty,
                            isBankNifty: live.isBankNifty,
                            isFinNifty: live.isFinNifty,
                            contestExpiry: live.contestExpiry,
                            contestStatus: live.contestStatus,
                            maxParticipants: live.maxParticipants,
                            contestStartTime: live.contestStartTime,
                            contestEndTime: live.contestEndTime,
                            payoutPercentage: live.payoutPercentage,
                            entryFee: live.entryFee,
                            portfolio: live.portfolio,
                          );
                        },
                      )
                  ] else if (controller.segmentedControlValue.value == 2) ...[
                    if (controller.premiumCompletedContestList.isNotEmpty)
                      CommonTile(label: 'Premium Contest\'s'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.premiumCompletedContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var completed = controller.premiumCompletedContestList[index];
                        var contestPnl = controller.completedContestPnlList[index];
                        return CompletedContestCard(
                          contestName: completed.contestName,
                          isNifty: completed.isNifty,
                          isBankNifty: completed.isBankNifty,
                          isFinNifty: completed.isFinNifty,
                          isAllIndex: completed.isAllIndex,
                          contestStartTime: completed.contestStartTime,
                          contestEndTime: completed.contestEndTime,
                          contestStatus: completed.contestStatus,
                          entryFee: completed.entryFee,
                          payoutPercentage: completed.payoutPercentage,
                          contestExpiry: completed.contestExpiry,
                          portfolio: contestPnl.portfolioValue,
                          npnl: contestPnl.npnl,
                          payoutAmount: contestPnl.payoutAmount,
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    if (controller.freeCompletedContestList.isNotEmpty)
                      CommonTile(label: 'Free Contest\'s'),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.freeCompletedContestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var completed = controller.freeCompletedContestList[index];
                        var contestPnl = controller.completedContestPnlList[index];
                        return CompletedContestCard(
                          contestName: completed.contestName,
                          isNifty: completed.isNifty,
                          isBankNifty: completed.isBankNifty,
                          isFinNifty: completed.isFinNifty,
                          isAllIndex: completed.isAllIndex,
                          contestStartTime: completed.contestStartTime,
                          contestEndTime: completed.contestEndTime,
                          contestStatus: completed.contestStatus,
                          entryFee: completed.entryFee,
                          payoutPercentage: completed.payoutPercentage,
                          contestExpiry: completed.contestExpiry,
                          portfolio: contestPnl.portfolioValue,
                          npnl: contestPnl.npnl,
                          payoutAmount: contestPnl.payoutAmount,
                        );
                      },
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
