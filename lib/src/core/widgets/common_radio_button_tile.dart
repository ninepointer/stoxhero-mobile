import 'package:flutter/material.dart';

import '../core.dart';

class CommonRadioButtonTile extends StatelessWidget {
  final String label;
  final int value;
  final int groupValue;
  final Function(int)? onChanged;
  const CommonRadioButtonTile({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey.shade50.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: value,
              groupValue: groupValue,
              activeColor: AppColors.secondary,
              onChanged: (int? newValue) {
                onChanged!(newValue!);
              },
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.tsMedium12,
            ),
          ],
        ),
      ),
    );
  }
}


// class CommonRadioButtonTile extends StatefulWidget {
//   final String label;
//   final int value;
//   final int groupValue;
//   final Function(int)? onChanged;
//   const CommonRadioButtonTile({
//     Key? key,
//     required this.label,
//     required this.value,
//     required this.groupValue,
//     this.onChanged,
//   }) : super(key: key);

//   @override
//   State<CommonRadioButtonTile> createState() => _CommonRadioButtonTileState();
// }

// class _CommonRadioButtonTileState extends State<CommonRadioButtonTile> {
//   bool isEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     isEnabled = widget.value == widget.groupValue; // Enable if this is the selected option.
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: AppColors.grey.shade50.withOpacity(0.5),
//             width: 1,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Radio(
//               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               value: widget.value,
//               groupValue: widget.groupValue,
//               activeColor: AppColors.secondary,
//               onChanged: (int? newValue) {
//                 if (newValue != null) {
//                   setState(() {
//                     widget.onChanged?.call(newValue); // Notify the parent when the radio button is tapped
//                     isEnabled = !isEnabled; // Toggle the enabled/disabled state
//                   });
//                 }
//               },
//             ),
//             Text(
//               widget.label,
//               style: Theme.of(context).textTheme.tsMedium12,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
