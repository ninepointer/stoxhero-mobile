import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CompletedContestChampionLeaderBoard extends GetView<ContestController> {
  final int? index;
  final ContestData? contestdata;

  const CompletedContestChampionLeaderBoard({
    Key? key,
    this.index,
    this.contestdata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: CommonCard(
        children: [
          Text('${contestdata?.contestName} - ${FormatHelper.formatDateMonth(contestdata?.contestDate)}'),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: contestdata?.topParticipants?.length ?? 0,
            itemBuilder: (context, index) {
              LastPaidTestZoneTopPerformer participant = contestdata!.topParticipants![index];
              return CommonCard(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(participant.rank.toString()),
                      CircleAvatar(
                        backgroundImage: NetworkImage(participant.profilePhoto?.url ?? ''),
                      ),
                      Text('${participant.firstName} ${participant.lastName}'),
                      Text('${participant.payout}'),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
