import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';

class DSIconButton extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback? onTap;

  const DSIconButton({
    super.key,
    required this.icon,
    this.iconSize = 20,
    this.iconColor = AppColors.primaryText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: onTap,
      child: Ink(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
