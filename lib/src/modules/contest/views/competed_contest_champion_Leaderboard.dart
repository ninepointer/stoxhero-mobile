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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${contestdata?.contestName} - ${FormatHelper.formatDateMonth(contestdata?.contestDate)}'),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: contestdata?.topParticipants?.length ?? 0,
              itemBuilder: (context, index) {
                LastPaidTestZoneTopPerformer participant =
                    contestdata!.topParticipants![index];

                return CommonCard(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(participant.rank.toString()),
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(participant.profilePhoto?.url ?? ''),
                        ),
                        Text(
                            '${participant.firstName} ${participant.lastName}'),
                        Text('${participant.payout}'),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
