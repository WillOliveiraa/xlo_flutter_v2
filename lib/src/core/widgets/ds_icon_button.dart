import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';

class DSIconButton extends StatelessWidget {
  final Widget child;

  const DSIconButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
