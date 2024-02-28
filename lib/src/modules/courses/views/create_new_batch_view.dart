import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class CreateNewBatchView extends StatefulWidget {
  const CreateNewBatchView({super.key});

  @override
  State<CreateNewBatchView> createState() => _CreateNewBatchViewState();
}

class _CreateNewBatchViewState extends State<CreateNewBatchView> {
  late CourseController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Course"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.value();
        },
        child: Visibility(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0306,
                vertical: MediaQuery.of(context).size.width * 0.0306),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Course Name",
                  style: AppStyles.tsBlackMedium14,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                CommonTextField(
                  isDisabled: false,
                  prefixIcon: Icon(Icons.batch_prediction_outlined),
                  controller: controller.batchNameTextController,
                  hintText: 'Enter Course Name',
                  padding: EdgeInsets.zero,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                Text(
                  "Course Start Date",
                  style: AppStyles.tsBlackMedium14,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                GestureDetector(
                  onTap: () => controller.showDateRangePicker(context),
                  child: CommonTextField(
                    padding: EdgeInsets.zero,
                    isDisabled: true,
                    controller: controller.batchStartDateTextController,
                    hintText: 'Select Course Start Date',
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      backgroundColor: AppColors.lightGreen,
                    ),
                    child: Text(
                      'Create Course',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
