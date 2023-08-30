import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class TutorialView extends StatefulWidget {
  const TutorialView({Key? key}) : super(key: key);

  @override
  _TutorialViewState createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  int segmentedControlValue = 0;

  Widget _segmentedControl() => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 16),
        child: CupertinoSegmentedControl<int>(
          selectedColor: AppColors.primary,
          borderColor: AppColors.primary,
          unselectedColor: Colors.transparent,
          children: {
            0: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'App Tutorial',
                style: AppStyles.tsWhiteRegular16,
              ),
            ),
            1: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Option Trading',
                style: AppStyles.tsWhiteRegular16,
              ),
            ),
          },
          onValueChanged: (int val) {
            setState(() {
              segmentedControlValue = val;
            });
          },
          groupValue: segmentedControlValue,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorials'),
      ),
      body: Column(
        children: [
          _segmentedControl(),
        ],
      ),
    );
  }
}
