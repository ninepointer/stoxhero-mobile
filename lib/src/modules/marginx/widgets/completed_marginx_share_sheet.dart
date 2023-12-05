import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../app/app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class ShareMarginXModalContent extends GetView<MarginXController> {
  final CompletedMarginX? marginx;
  const ShareMarginXModalContent({
    Key? key,
    this.marginx,
  }) : super(key: key);

  Future<void> _captureAndSharePng(GlobalKey cardKey) async {
    RenderRepaintBoundary boundary =
        cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 5);
    ByteData byteData =
        (await image.toByteData(format: ui.ImageByteFormat.png))!;

    Uint8List pngBytes = byteData.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    File imgFile = File('${tempDir.path}/share_image.png');
    await imgFile.writeAsBytes(pngBytes);

    Share.shareFiles([imgFile.path], text: getShareMessage());
  }

  String getShareMessage() {
    return "Hey!! \n\nI just won INR ${FormatHelper.formatNumbers((marginx?.earning ?? 0) + (marginx?.tds ?? 0), decimal: 0)} in ${marginx?.marginxName} TestZone on StoxHero app.\n\nThis is a super exciting way to learn Stocks Market Trading and Win Cash rewards !!\n\nDownload the App:\nhttps://play.google.com/store/apps/details?id=com.stoxhero.app&pli=1";
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey cardKey = GlobalKey();
    return Container(
        height: 700,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(top: 100),
        child: Column(
          // shrinkWrap: true,

          children: [
            RepaintBoundary(
              key: cardKey,
              child: Container(
                width: double.infinity,
                child: CommonCard(
                  hasBorder: true,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages
                              .testZoneShareBackground), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.lightAppName,
                                height: 30,
                                width: 100,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'MarginX',
                                    style: AppStyles.tsSecondaryMedium24
                                        .copyWith(color: AppColors.warning),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('WINNER',
                                      style: AppStyles.tsSecondaryRegular16
                                          .copyWith(color: AppColors.white)),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white.withOpacity(.50),
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: controller.userDetails.value
                                                  .profilePhoto ==
                                              null
                                          ? Image.asset(
                                              AppImages.darkAppLogo,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              controller.userDetails.value
                                                      .profilePhoto?.url ??
                                                  '',
                                              //     fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '${controller.userDetails.value.firstName} ${controller.userDetails.value.lastName}',
                                      style: AppStyles.tsSecondaryMedium16
                                          .copyWith(color: AppColors.white))
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '@${controller.userDetails.value.employeeid}',
                                      style: AppStyles.tsSecondaryRegular16
                                          .copyWith(color: AppColors.white))
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text("Fee",
                                            style: AppStyles
                                                .tsSecondaryRegular14
                                                .copyWith(
                                                    color: AppColors.white)),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            "${FormatHelper.formatNumbers(marginx?.entryFee, decimal: 0)}",
                                            style: AppStyles.tsSecondaryMedium16
                                                .copyWith(
                                                    color: AppColors.white))
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 17),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Net P&L",
                                            style: AppStyles
                                                .tsSecondaryRegular14
                                                .copyWith(
                                              color: AppColors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            FormatHelper.formatNumbers(
                                                marginx?.npnl,
                                                decimal: 0),
                                            style: AppStyles.tsSecondaryMedium16
                                                .copyWith(
                                                    color: AppColors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text("Reward",
                                            style: AppStyles
                                                .tsSecondaryRegular14
                                                .copyWith(
                                                    color: AppColors.white)),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            FormatHelper.formatNumbers(
                                                (marginx?.earning ?? 0) +
                                                    (marginx?.tds ?? 0),
                                                decimal: 0),
                                            style: AppStyles.tsSecondaryMedium16
                                                .copyWith(
                                                    color: AppColors.white))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 150,
                                child: Divider(
                                  height: 1,
                                  thickness: 2,
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('MarginX',
                                      style: AppStyles.tsSecondaryRegular12
                                          .copyWith(
                                        color: AppColors.white,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${marginx?.marginxName}",
                                      style: AppStyles.tsSecondaryMedium14
                                          .copyWith(color: AppColors.white))
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      FormatHelper.formatDateInMonth(
                                          marginx?.endTime),
                                      style: AppStyles.tsSecondaryRegular12
                                          .copyWith(color: AppColors.white))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Stock market seekhna hai to ',
                                          style: AppStyles.tsSecondaryRegular14
                                              .copyWith(color: AppColors.white),
                                        ),
                                        WidgetSpan(
                                          child: Image.asset(
                                            AppImages.lightAppName,
                                            height: 16,
                                            width: 70,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' aa jao',
                                          style: AppStyles.tsSecondaryRegular14
                                              .copyWith(color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 6),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return AppColors.darkGreen; // Color when pressed
                        }
                        return AppColors.lightGreen; // Default color
                      },
                    ),
                  ),
                  onPressed: () {
                    _captureAndSharePng(cardKey);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Share Your Achievements',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
