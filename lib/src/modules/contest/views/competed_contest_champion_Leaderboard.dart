import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CompletedContestChampionLeaderBoard extends GetView<ContestController> {
  final int? index;
  final ContestData? contestdata;
  final LastPaidTestZoneTopPerformer? participant;
  const CompletedContestChampionLeaderBoard({
    Key? key,
    this.index,
    this.contestdata,
    this.participant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('contestdata${controller.contestChampionList}');
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('${contestdata?.contestName} - '),
              Text(FormatHelper.formatDateMonth(contestdata?.contestDate)),
              // Text(contestdata?.topParticipants
              //         ?.map((e) => e.firstName)
              //         .join(', ') ??
              //     ''),
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemCount: contestdata?.topParticipants?.length ?? 0,
            itemBuilder: (context, index) {
              // final LastPaidTestZoneTopPerformer participant =
              //     controller.contestChampionList[index].topParticipants![index];
              return CommonCard(
                margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                padding: EdgeInsets.only(top: 8, right: 16, left: 8, bottom: 8),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(participant!.rank.toString()),
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(participant!.profilePhoto?.url ?? ''),
                      ),
                      Text(
                          '${participant!.firstName} ${participant!.lastName}'),
                      Text('${participant!.payout}'),
                    ],
                  ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}
