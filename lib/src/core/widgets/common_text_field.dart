import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

class CommonTextField extends StatelessWidget {
  final EdgeInsets? padding;
  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final int? maxLines;
  final bool hasLabel;
  final bool isDisabled;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;
  const CommonTextField({
    Key? key,
    this.padding,
    this.controller,
    required this.hintText,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.maxLines,
    this.hasLabel = false,
    this.isDisabled = false,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasLabel)
            Text(
              hintText,
              style: AppStyles.tsGreyRegular14,
            ),
          if (hasLabel) SizedBox(height: 4),
          AbsorbPointer(
            absorbing: isDisabled,
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              validator: validator,
              onChanged: onChanged,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              obscureText: obscureText ?? false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: Theme.of(context).textTheme.tsRegular16,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(14),
                filled: true,
                fillColor: AppColors.grey.withOpacity(.1),
                hintText: hintText,
                hintStyle: AppStyles.tsGreyRegular16,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                errorStyle: AppStyles.tsGreyRegular12.copyWith(
                  color: AppColors.danger.shade700,
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.primary,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.danger,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
