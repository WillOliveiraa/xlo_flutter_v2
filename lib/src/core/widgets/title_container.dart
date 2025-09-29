import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const TitleContainer({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            style: TextTheme.of(
              context,
            ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                subtitle ?? 'See All',
                maxLines: 1,
                style: TextTheme.of(context).bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
