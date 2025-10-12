import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/spacings/spacing.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';

class DSIconButton extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final double? width;
  final double? height;
  final Color? iconColor;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const DSIconButton({
    super.key,
    required this.icon,
    this.iconSize = 20,
    this.width = Spacing.x4,
    this.height = Spacing.x4,
    this.iconColor = AppColors.primaryText,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: onTap,
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
