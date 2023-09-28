import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class KycDetailsView extends StatefulWidget {
  const KycDetailsView({Key? key}) : super(key: key);

  @override
  State<KycDetailsView> createState() => _KycDetailsViewState();
}

class _KycDetailsViewState extends State<KycDetailsView> {
  late BankController controller;
  List<File?> images = List.generate(5, (_) => null);

  List<PlatformFile> filesList = [];

  @override
  void initState() {
    controller = Get.find<BankController>();
    super.initState();
  }

  Future pickImage(int index) async {
    try {
      // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // if (image == null) return;
      // final imageTemporary = File(image.path);

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
      );
      filesList = result?.files ?? [];
      // NetworkService().postAuthFormData(path: result, data: filesList);
      if (result != null) {
        File file = File(result.files.single.path ?? '');
        String filename = file.path.split('/').last;
      }

      log(filesList.toString());

      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to pick Image $e');
    }
  }

  void removeImage(int index) {
    setState(() {
      images[index] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('KYC Details'),
          actions: [
            IconButton(
              splashRadius: 24,
              icon: controller.isEditEnabled.value ? Icon(Icons.save) : Icon(Icons.edit),
              onPressed: controller.userDetails.value.kYCStatus == 'Approved'
                  ? null
                  : () {
                      if (controller.isEditEnabled.value) {
                        controller.saveUserKYCDetails();
                      }
                      controller.isEditEnabled.toggle();
                      FocusScope.of(context).unfocus();
                    },
            )
          ],
        ),
        body: Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: AbsorbPointer(
                absorbing: !controller.isEditEnabled.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'KYC Status: ${controller.userDetails.value.kYCStatus}',
                      style: Theme.of(context).textTheme.tsMedium14,
                    ),
                    SizedBox(height: 8),
                    CommonTextField(
                      hintText: 'Aadhaar Card Number',
                      keyboardType: TextInputType.number,
                      controller: controller.aadhaarCardNumberTextController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    CommonTextField(
                      hintText: 'PAN Card Number',
                      controller: controller.panCardNumberTextController,
                    ),
                    CommonTextField(
                      hintText: 'Passport Number',
                      controller: controller.passportCardNumberTextController,
                    ),
                    CommonTextField(
                      hintText: 'Driving License Number',
                      controller: controller.drivingLicenseNumberTextController,
                    ),
                    buildImage(
                      label: 'Aadhaar Card Front Image',
                      imageUpload: () => pickImage(0),
                      removeImage: images[0] != null ? () => removeImage(0) : null,
                      image: images[0],
                    ),
                    SizedBox(height: 12),
                    buildImage(
                      label: 'Aadhaar Card Back Image',
                      imageUpload: () => pickImage(1),
                      removeImage: images[1] != null ? () => removeImage(1) : null,
                      image: images[1],
                    ),
                    SizedBox(height: 12),
                    buildImage(
                      label: 'Pan Card Image',
                      imageUpload: () => pickImage(2),
                      removeImage: images[2] != null ? () => removeImage(2) : null,
                      image: images[2],
                    ),
                    SizedBox(height: 12),
                    buildImage(
                      label: 'Passport Size Image',
                      imageUpload: () => pickImage(3),
                      removeImage: images[3] != null ? () => removeImage(3) : null,
                      image: images[3],
                    ),
                    SizedBox(height: 12),
                    buildImage(
                      label: 'Address Proof Image',
                      imageUpload: () => pickImage(4),
                      removeImage: images[4] != null ? () => removeImage(4) : null,
                      image: images[4],
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage({
    required String label,
    required VoidCallback imageUpload,
    VoidCallback? removeImage,
    File? image,
  }) {
    String imageType = '';
    if (image != null) {
      if (image.path.endsWith('.jpg') || image.path.endsWith('.jpeg')) {
        imageType = 'JPEG Image';
      } else if (image.path.endsWith('.png')) {
        imageType = 'PNG Image';
      } else {
        imageType = 'Unknown Image Type';
      }
    }
    return GestureDetector(
      onTap: imageUpload,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (image != null)
                Image.file(
                  image,
                  width: 100,
                  height: 100,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label),
                  SizedBox(height: 4),
                  Text(imageType),
                ],
              ),
              if (image != null && removeImage != null)
                IconButton(
                  onPressed: () => removeImage(),
                  icon: Icon(Icons.cancel),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
