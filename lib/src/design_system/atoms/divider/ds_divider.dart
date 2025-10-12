import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';

enum OrientationDivider { horizontal, vertical }

class DSDivider extends StatelessWidget {
  final double thickness;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final OrientationDivider orientation;

  const DSDivider._({
    super.key,
    required this.thickness,
    this.margin,
    this.color,
    this.orientation = OrientationDivider.horizontal,
  });

  factory DSDivider.medium({
    Key? key,
    EdgeInsetsGeometry? margin,
    OrientationDivider? orientation,
    Color? color,
  }) {
    return DSDivider._(
      key: key,
      thickness: 4,
      margin: margin,
      orientation: orientation ?? OrientationDivider.horizontal,
      color: color ?? AppColors.grey20,
    );
  }

  factory DSDivider.small({
    Key? key,
    EdgeInsetsGeometry? margin,
    OrientationDivider? orientation,
    Color? color,
  }) {
    return DSDivider._(
      key: key,
      thickness: 1,
      margin: margin,
      orientation: orientation ?? OrientationDivider.horizontal,
      color: color ?? AppColors.grey20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child:
          orientation == OrientationDivider.horizontal
              ? Divider(height: 0, color: color, thickness: thickness)
              : VerticalDivider(width: 0, color: color, thickness: thickness),
    );
  }
}
