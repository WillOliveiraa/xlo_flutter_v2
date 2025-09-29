import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';

class CustomBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? subtitle;
  final String? labelButton;
  final VoidCallback? onTap;

  const CustomBanner({
    super.key,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.labelButton,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              title,
              maxLines: 1,
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(color: AppColors.secondaryBackground),
            ),
          ),
          Positioned(
            top: 45,
            left: 20,
            child: Visibility(
              visible: subtitle != null,
              child: Text(
                subtitle ?? '',
                style: TextTheme.of(context).bodyMedium?.copyWith(
                  color: AppColors.secondaryBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 28,
            left: 20,
            child: Container(
              width: 116,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  'Shop Now',
                  textAlign: TextAlign.start,
                  style: TextTheme.of(context).bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.secondaryBackground.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
