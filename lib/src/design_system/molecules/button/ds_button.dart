import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/spacings/spacing.dart';
import 'package:xlo_flutter_v2/src/design_system/atoms/text/ds_text.dart';

class DSButton extends StatelessWidget {
  final String? label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? iconSizeLeading;
  final double? iconSizeTrailing;
  final bool isLoading;

  const DSButton({
    super.key,
    this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.onPressed,
    this.margin,
    this.color,
    this.textColor,
    this.iconColor = Colors.white,
    this.width,
    this.height,
    this.iconSizeLeading,
    this.iconSizeTrailing,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isLoading) ...[
            Visibility(
              visible: leadingIcon != null,
              child: Icon(leadingIcon, color: iconColor, size: iconSizeLeading),
            ),
            Flexible(
              child:
                  label != null
                      ? DSText(
                        label!,
                        // style: getTextTheme(context, sizeButton),
                        overflow: TextOverflow.ellipsis,
                        margin: EdgeInsets.only(
                          left: leadingIcon != null ? Spacing.x1 : Spacing.zero,
                          right:
                              trailingIcon != null ? Spacing.x1 : Spacing.zero,
                        ),
                      )
                      : const SizedBox(),
            ),
            Visibility(
              visible: trailingIcon != null,
              child: Icon(
                trailingIcon,
                color: iconColor,
                size: iconSizeTrailing,
              ),
            ),
          ] else
            SizedBox(
              width: Spacing.x3,
              height: Spacing.x3,
              child: CircularProgressIndicator(color: iconColor),
            ),
        ],
      ),
    );
  }
}
