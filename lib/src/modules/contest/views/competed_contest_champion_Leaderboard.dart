import 'package:flutter/material.dart';
import '../../../app/app.dart';
import 'package:intl/intl.dart';

class CompletedContestChampionLeaderBoard extends GetView<ContestController> {
  final int? index;
  final ContestData? contestdata;
  final double cardWidth;

  const CompletedContestChampionLeaderBoard({
    Key? key,
    this.index,
    this.contestdata,
    required this.cardWidth,
  }) : super(key: key);
  static String formatDateMonthth(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('d').format(dateTime);

      // Add the appropriate ordinal suffix
      formattedString += _getDaySuffix(dateTime.day);

      formattedString += ' ' + DateFormat('MMM').format(dateTime);
      return formattedString;
    } else {
      return '-';
    }
  }

  static String _getDaySuffix(int day) {
    // if (day >= 11 && day <= 20) {
    //   return 'th';
    // }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,

      width: cardWidth,

      child: CommonCard(
        margin: EdgeInsets.only(top: 8, right: 8, left: 12, bottom: 8),
        padding: EdgeInsets.all(8.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '${contestdata?.contestName}',
                    style: AppStyles.tsSecondaryMedium14,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${formatDateMonthth(contestdata?.contestDate)}',
                    style: AppStyles.tsGreyMedium14,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 3),
          Container(
            height: 170,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: contestdata?.topParticipants?.length ?? 0,
              itemBuilder: (context, index) {
                LastPaidTestZoneTopPerformer participant =
                    contestdata!.topParticipants![index];
                return Padding(
                  padding:
                      const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child:
                            // Text(
                            //   '${participant.rank == 1 ? Image.asset(AppImages.rank1) : participant.rank == 2 ? Image.asset(AppImages.rank2) : participant.rank == 3 ? Image.asset(AppImages.rank3) : ''}',
                            // ),
                            Row(
                          children: [
                            Image.asset(
                              participant.rank == 1
                                  ? AppImages.rank1
                                  : participant.rank == 2
                                      ? AppImages.rank2
                                      : participant.rank == 3
                                          ? AppImages.rank3
                                          : AppImages.rank2,
                              width: 30,
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          // color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.grey.withOpacity(.25),
                          ),
                        ),
                        child: ClipOval(
                          child: participant.profilePhoto == null
                              ? Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Image.asset(
                                    Get.isDarkMode
                                        ? AppImages.darkAppLogo
                                        : AppImages.lightAppLogo,
                                    fit: BoxFit.cover,
                                  ))
                              : Image.network(
                                  participant.profilePhoto?.url ?? '',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),

                      Container(
                          alignment: Alignment.centerLeft,
                          width: 90,
                          child: Text(
                            participant.firstName != null
                                ? '${participant.firstName?.toString().capitalize}'
                                : "User",
                            style: Theme.of(context).textTheme.tsRegular14,
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: 60,
                          child: Text(
                            '${FormatHelper.formatNumbers(participant.payout?.round(), showDecimal: false)}',
                            style: Theme.of(context).textTheme.tsRegular14,
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
