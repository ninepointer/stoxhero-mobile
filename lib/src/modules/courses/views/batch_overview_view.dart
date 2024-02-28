import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class BatchOverViewDetailsView extends StatefulWidget {
  const BatchOverViewDetailsView({super.key});

  @override
  State<BatchOverViewDetailsView> createState() =>
      _BatchOverViewDetailsViewState();
}

class _BatchOverViewDetailsViewState extends State<BatchOverViewDetailsView> {
  String txt =
      "Students are trained to set goals of a properly planned investment,They learn about the basic concept, rules and laws involved in the Stock Market Industry,Students are trained to set goals of a properly planned investment";

  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'))
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                CustomVideoPlayer(
                    customVideoPlayerController: _customVideoPlayerController),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkCardBackgroundColor
                          : AppColors.lightCardBackgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is equity?",
                        style: AppStyles.tsBlackMedium16,
                      ),
                      Text(
                        "By - Rakesh Kumar",
                        style: AppStyles.tsBlackRegular14,
                      ),
                      Text(
                        "Language - Hindi",
                        style: AppStyles.tsBlackRegular14,
                      ),
                      Text(
                        "Course category - Trading",
                        style: AppStyles.tsBlackRegular14,
                      ),
                      Text(
                        "Course duration - ${formatDuration(70)} ",
                        style: AppStyles.tsBlackRegular14,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Benefits of course:-",
                      style: AppStyles.tsBlackMedium14,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0102,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkCardBackgroundColor
                          : AppColors.lightCardBackgroundColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: txt
                        .split(",")
                        .map((value) => textItemWidget(value))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Course overview:-",
                      style: AppStyles.tsBlackMedium14,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkCardBackgroundColor
                          : AppColors.lightCardBackgroundColor),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Flexible(
                            child: Text(
                              "Students are trained to set goals of a properly planned investment",
                              style: AppStyles.tsBlackRegular14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Flexible(
                            child: Text(
                              "They learn about the basic concept, rules and laws involved in the Stock Market Industry.",
                              style: AppStyles.tsBlackRegular14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Flexible(
                            child: Text(
                              "They train the students to learn the strategies and tactics to reduce the risk factors and learn the right way to invest little and receive more.",
                              style: AppStyles.tsBlackRegular14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Flexible(
                            child: Text(
                              "Students learn the art of studying statistics and learn the art of making the right decisions.",
                              style: AppStyles.tsBlackRegular14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Flexible(
                            child: Text(
                              "The students are offered various internship opportunities where they get guided training from the professionals and they learn from real life experiences.",
                              style: AppStyles.tsBlackRegular14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Course description:-",
                      style: AppStyles.tsBlackMedium14,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkCardBackgroundColor
                          : AppColors.lightCardBackgroundColor),
                  child: Html(data: """<div>
                            <h1>This is a heading</h1>
                            <p>This is a paragraph.</p>
                            <p>This is another paragraph with <strong>bold</strong> text.</p>
                            <p>This is a paragraph with <em>italic</em> text.</p>
                            <p>This is a paragraph with <u>underlined</u> text.</p>
                            <p>This is a paragraph with <span style="color: red;">colored</span> text.</p>
                            <p>This is a paragraph with <a href="https://example.com">a link</a>.</p>
                            <p>This is a paragraph with an <img src="https://example.com/image.jpg" alt="Image" />.</p>
                          </div>"""),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Course topics:-",
                      style: AppStyles.tsBlackMedium14,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0204,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.darkCardBackgroundColor
                          : AppColors.lightCardBackgroundColor),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Flexible(
                            child: Text(
                              "Students are trained to set goals of a properly planned investment",
                              style: AppStyles.tsBlackRegular14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Flexible(
                            child: Text(
                              "They learn about the basic concept, rules and laws involved in the Stock Market Industry.",
                              style: AppStyles.tsBlackRegular14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.0102,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.0102,
                          ),
                          Flexible(
                            child: Text(
                              "They train the students to learn the strategies and tactics to reduce the risk factors and learn the right way to invest little and receive more.",
                              style: AppStyles.tsBlackRegular14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isStudent) ...{
          SafeArea(
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    BottomSheetHelper.openBottomSheet(
                      context: context,
                      child: PaymentBottomSheet(
                        productType: ProductType.contest,
                        productId: '',
                        buyItemPrice: 0,
                        onPaymentSuccess: () {},
                        onSubmit: () {
                          Get.back();
                          // var walletController = Get.find<WalletController>();
                          // var data = {
                          //   "bonusRedemption":
                          //       walletController.isHeroCashAdded.value
                          //           ? walletController.heroCashAmount.value
                          //           : 0,
                          //   "coupon":
                          //       walletController.couponCodeTextController.text,
                          //   "contestFee": walletController.subscriptionAmount.value,
                          //   "contestId": liveFeatured?.id,
                          //   "contestName": liveFeatured?.contestName,
                          // };
                          // controller.purchaseContest(data);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGreen,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Button border radius
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Buy @ "),
                      Text(
                        "${FormatHelper.formatNumbers(100, decimal: 0)}",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                            decorationThickness: 3),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text("${FormatHelper.formatNumbers(80, decimal: 0)}")
                    ],
                  )),
            ),
          )
        } else ...{
          SafeArea(
              child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGreen,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Button border radius
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Approve"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.0204,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Suggest Change'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.width * 0.3,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: TextField(
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Suggestions',
                                    border: InputBorder.none,
                                  ),
                                ),

                                // Allow multiple lines for feedback
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle sending feedback
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Send'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGreen,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Button border radius
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Suggestion"),
                    ],
                  ),
                ),
              ),
            ],
          ))
        }
      ],
    );
  }
}

Widget textItemWidget(String str) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Icon(
            Icons.circle,
            size: 8,
            color: AppColors.grey,
          ),
        ],
      ),
      SizedBox(
        width: 4,
      ),
      Flexible(
        child: Text(
          str,
          style: AppStyles.tsBlackRegular14,
        ),
      ),
    ],
  );
}

String formatDuration(int minutes) {
  if (minutes >= 60) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '$hours hr : $remainingMinutes min';
  } else {
    return '$minutes min';
  }
}
