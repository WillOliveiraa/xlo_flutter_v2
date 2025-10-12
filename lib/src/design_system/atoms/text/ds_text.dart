import 'package:flutter/material.dart';

class DSText extends StatelessWidget {
  final String data;
  final String? fallback;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Function(String?)? onLinkTap;
  final VoidCallback? onActionTap;
  final Map<String, dynamic>? params;
  final int? maxLength;

  const DSText(
    this.data, {
    super.key,
    this.params,
    this.style,
    this.fallback,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.margin,
    this.onTap,
    this.onLinkTap,
    this.onActionTap,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    var text = fallback ?? data;

    if (maxLength != null && maxLength! < text.length) {
      text = '${text.substring(0, maxLength).trim()} ...';
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: margin,
        child: Semantics(
          label: semanticsLabel,
          child: Text(
            _scapedCharacters(text),
            style: style,
            textAlign: textAlign,
            textDirection: textDirection,
            softWrap: softWrap,
            overflow: overflow,
            textScaler:
                textScaleFactor != null
                    ? TextScaler.linear(textScaleFactor!)
                    : null,
            maxLines: maxLines,
          ),
        ),
      ),
    );
  }

  String _scapedCharacters(String text) {
    return text.replaceAll("'", '&apos;');
  }
}
