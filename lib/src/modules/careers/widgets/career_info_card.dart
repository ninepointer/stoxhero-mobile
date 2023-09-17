import 'package:flutter/material.dart';
import '../../../core/core.dart';

class CareerInfoCard extends StatelessWidget {
  final String label;
  final bool isInternship;
  final VoidCallback onPressed;

  const CareerInfoCard({
    Key? key,
    required this.label,
    required this.isInternship,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
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
                  Icons.school,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.tsMedium18,
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 1, height: 0),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Lead virtual trading program, guiding participants in stock market simulations. Foster collaborative learning, refining financial strategies in a risk-free space. Empower growth in practical trading skills as Virtual Trading.',
            style: AppStyles.tsGreyRegular14,
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isInternship ? AppColors.success : AppColors.success,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  isInternship ? 'Internship' : 'Workshop',
                  textAlign: TextAlign.center,
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.info,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Work from home',
                  textAlign: TextAlign.center,
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: CommonFilledButton(
            label: 'Click here to Apply!',
            height: 42,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
