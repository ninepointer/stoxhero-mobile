import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../app/app.dart';

class CommonImageUpload extends StatelessWidget {
  final String? label;
  final VoidCallback? selectFile;
  final VoidCallback? removeFile;
  final PlatformFile? file;
  const CommonImageUpload({
    Key? key,
    this.label,
    this.selectFile,
    this.removeFile,
    this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasFile = (file?.path != null);
    return GestureDetector(
      onTap: selectFile,
      child: CommonCard(
        margin: EdgeInsets.zero,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasFile ? AppColors.success.withOpacity(.25) : AppColors.grey.withOpacity(.25),
                ),
                child: Icon(
                  hasFile ? Icons.verified_rounded : Icons.description_rounded,
                  size: 20,
                  color: hasFile ? AppColors.success : AppColors.grey,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label ?? '',
                      style: Theme.of(context).textTheme.tsRegular16,
                    ),
                    if (hasFile) ...[
                      Text(
                        file?.name ?? '',
                        style: AppStyles.tsGreyRegular14,
                      ),
                    ]
                  ],
                ),
              ),
              if (hasFile)
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: removeFile,
                  splashRadius: 24,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
