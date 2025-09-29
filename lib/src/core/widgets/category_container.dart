import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';

class CategoryContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const CategoryContainer({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(color: AppColors.secondaryBackground),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 38),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextTheme.of(context).bodyMedium?.copyWith(
                fontSize: 14,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
