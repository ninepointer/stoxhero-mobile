import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app.dart';

class UpdateAlertDialog extends StatefulWidget {
  const UpdateAlertDialog({Key? key}) : super(key: key);

  @override
  State<UpdateAlertDialog> createState() => _UpdateAlertDialogState();
}

class _UpdateAlertDialogState extends State<UpdateAlertDialog> {
  void openAppPage() {
    final appId = Platform.isAndroid ? 'com.stoxhero.app' : 'com.stoxhero.app';
    final url = Uri.parse(
      Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId",
    );
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        contentPadding: EdgeInsets.all(16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.update_rounded,
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Update Available',
              style: Theme.of(Get.context!).textTheme.tsPrimaryMedium18,
            ),
            SizedBox(height: 8),
            Text(
              'Kindly update the StoxHero app to the latest version to continue!',
              style: Theme.of(Get.context!).textTheme.tsRegular16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CommonOutlinedButton(
                    backgroundColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                    labelColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                    width: double.infinity,
                    height: 42,
                    label: 'Cancel',
                    onPressed: Get.back,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CommonFilledButton(
                    width: double.infinity,
                    height: 42,
                    label: 'Update',
                    onPressed: openAppPage,
                    backgroundColor: Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
