import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_dimensions.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  
  const StatusBadge({super.key, required this.status});

  Color _getBackgroundColor() {
    switch (status.toUpperCase()) {
      case 'APPROVED':
      case 'RESOLVED':
        return AppColors.success.withOpacity(0.1);
      case 'REJECTED':
      case 'DISMISSED':
        return AppColors.error.withOpacity(0.1);
      case 'PENDING':
      case 'WARNING':
        return AppColors.warning.withOpacity(0.1);
      case 'UNDER_REVIEW':
      case 'INFO':
        return AppColors.info.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }

  Color _getTextColor() {
    switch (status.toUpperCase()) {
      case 'APPROVED':
      case 'RESOLVED':
        return AppColors.success;
      case 'REJECTED':
      case 'DISMISSED':
        return AppColors.error;
      case 'PENDING':
      case 'WARNING':
        return AppColors.warning;
      case 'UNDER_REVIEW':
      case 'INFO':
        return AppColors.info;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall / 2,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(AppDimensions.radiusCircular),
      ),
      child: Text(
        status.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _getTextColor(),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}
