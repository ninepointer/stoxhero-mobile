import 'package:flutter/material.dart';

import '../../../core/core.dart';

class TutorialView extends StatefulWidget {
  const TutorialView({Key? key}) : super(key: key);

  @override
  _TutorialViewState createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  int segmentedControlValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorials'),
      ),
      body: Column(
        children: [
          CommonSegmentedControl(
            segments: {
              0: 'App Tutorial',
              1: 'Option Trading',
            },
            selectedSegment: segmentedControlValue,
            onValueChanged: (int val) => setState(() => segmentedControlValue = val),
          ),
        ],
      ),
    );
  }
}
