import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class CommonDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final Color? color;
  final ValueChanged<String?>? onChanged;
  final bool useSeptValue;
  final String? Function(String?)? getValue;
  const CommonDropdown({
    Key? key,
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.color,
    this.getValue,
    this.useSeptValue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton2<String>(
            hint: Text(
              hint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.tsGreyRegular14,
            ),
            value: value,
            onChanged: onChanged,
            items: dropdownItems.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    useSeptValue ? (getValue?.call(value) ?? value) : value,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.tsRegular12,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList(),
            dropdownStyleData: DropdownStyleData(
              elevation: 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.only(right: 12),
            ),
            iconStyleData: IconStyleData(
              iconEnabledColor: AppColors.grey,
              openMenuIcon: Icon(
                Icons.expand_less_rounded,
              ),
              icon: Icon(
                Icons.expand_more_rounded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
