import 'package:flutter/material.dart';

import '../../../app/app.dart';

class InternshipCertificateDownloadCard extends GetView<InternshipController> {
  const InternshipCertificateDownloadCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.internshipCertificate.length,
      itemBuilder: (context, index) {
        final batches = controller.internshipCertificate[index];
        return CommonCard(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(bottom: 8),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.workspace_premium,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Internship Batch',
                          style: AppStyles.tsGreyRegular12,
                        ),
                        Text(
                          '${batches.name} [${FormatHelper.formatDateYear(batches.startDate)} - ${FormatHelper.formatDateYear(batches.endDate)}]',
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
              child: CommonFilledButton(
                height: 42,
                label: 'Download Certificate',
                onPressed: () {
                  controller.internshipCertificateDownload(batches);
                  controller.downloadFile();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
