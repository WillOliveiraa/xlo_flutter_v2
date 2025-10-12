import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../core/theme/app_colors.dart';
import 'ds_skeleton_item.dart';

export 'ds_skeleton_item.dart';

///
/// An enum defines all supported directions of skeletons effect
///
/// * [DSSkeletonDirection.ltr] left to right direction
/// * [DSSkeletonDirection.rtl] right to left direction
/// * [DSSkeletonDirection.ttb] top to bottom direction
/// * [DSSkeletonDirection.btt] bottom to top direction
///
enum DSSkeletonDirection { ltr, rtl, ttb, btt }

@immutable
class DSSkeleton extends StatefulWidget {
  final Duration period;
  final DSSkeletonDirection direction;
  final Color? baseColor;
  final Color? highlightColor;

  /// The child of the [DSSkeleton] widget are:
  /// * [DSSkeletonColumn] wrap for [Column]
  /// * [DSSkeletonRow] wrap for [Row]
  /// * [DSSkeletonContainer] wrap for [Container]
  /// * [DSSkeletonExpanded] wrap for [Expanded]
  final DSSkeletonItem child;

  const DSSkeleton({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.period = const Duration(milliseconds: 1500),
    this.direction = DSSkeletonDirection.ltr,
  });

  @override
  State<DSSkeleton> createState() => _DSSkeletonState();
}

class _DSSkeletonState extends State<DSSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Color get baseColor => widget.baseColor ?? AppColors.grey10;
  Color get highlightColor =>
      widget.highlightColor ?? AppColors.grey10.withOpacity(.5);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.period);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder:
          (BuildContext context, Widget? child) => _Shimmer(
            direction: widget.direction,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                baseColor,
                baseColor,
                highlightColor,
                baseColor,
                baseColor,
              ],
              stops: const <double>[0.0, 0.35, 0.5, 0.65, 1.0],
            ),
            percent: _controller.value,
            child: child,
          ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@immutable
class _Shimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final DSSkeletonDirection direction;
  final Gradient gradient;

  const _Shimmer({
    super.child,
    required this.percent,
    required this.direction,
    required this.gradient,
  });

  @override
  _ShimmerFilter createRenderObject(BuildContext context) {
    return _ShimmerFilter(percent, direction, gradient);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.percent = percent;
    shimmer.gradient = gradient;
    shimmer.direction = direction;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  DSSkeletonDirection _direction;
  Gradient _gradient;
  double _percent;

  _ShimmerFilter(this._percent, this._direction, this._gradient);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue != _percent) {
      _percent = newValue;
      markNeedsPaint();
    }
  }

  set gradient(Gradient newValue) {
    if (newValue != _gradient) {
      _gradient = newValue;
      markNeedsPaint();
    }
  }

  set direction(DSSkeletonDirection newDirection) {
    if (newDirection != _direction) {
      _direction = newDirection;
      markNeedsLayout();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final double width = child!.size.width;
      final double height = child!.size.height;

      Rect rect;
      double dx, dy;

      if (_direction == DSSkeletonDirection.rtl) {
        dx = _offset(width, -width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      } else if (_direction == DSSkeletonDirection.ttb) {
        dx = 0.0;
        dy = _offset(-height, height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else if (_direction == DSSkeletonDirection.btt) {
        dx = 0.0;
        dy = _offset(height, -height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else {
        dx = _offset(-width, width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      }

      layer ??= ShaderMaskLayer();
      layer!
        ..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;

      context.pushLayer(layer!, super.paint, offset);
    } else {
      layer = null;
    }
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}
