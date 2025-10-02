import 'package:flutter/material.dart';

import '../../spacings/spacing.dart';

abstract class DSSkeletonItem extends StatelessWidget {
  const DSSkeletonItem({super.key});
}

class DSSkeletonColumn extends DSSkeletonItem {
  final List<DSSkeletonItem> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final EdgeInsetsGeometry? padding;

  const DSSkeletonColumn({
    super.key,
    this.children = const [],
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textDirection,
    this.textBaseline,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(Spacing.zero),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        textDirection: textDirection,
        textBaseline: textBaseline,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: verticalDirection,
        children: children,
      ),
    );
  }
}

class DSSkeletonRow extends DSSkeletonItem {
  final List<DSSkeletonItem> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final EdgeInsetsGeometry? padding;

  const DSSkeletonRow({
    super.key,
    this.children = const [],
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textDirection,
    this.textBaseline,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(Spacing.zero),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        textDirection: textDirection,
        textBaseline: textBaseline,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: verticalDirection,
        children: children,
      ),
    );
  }
}

class DSSkeletonContainer extends DSSkeletonItem {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;
  final EdgeInsetsGeometry? margin;

  const DSSkeletonContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isRectangle = shape == BoxShape.rectangle;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isRectangle ? borderRadius : null,
        shape: shape,
      ),
      width: width,
      height: height ?? Spacing.zero,
    );
  }
}

class DSSkeletonExpanded extends DSSkeletonItem {
  final DSSkeletonItem child;
  final int flex;

  const DSSkeletonExpanded({
    super.key,
    required this.child,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: flex, child: child);
  }
}
