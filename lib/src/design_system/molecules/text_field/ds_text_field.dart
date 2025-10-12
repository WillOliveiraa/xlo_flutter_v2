import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_flutter_v2/src/core/spacings/spacing.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/design_system/atoms/icon_button/ds_icon_button.dart';

import '../../atoms/text/ds_text.dart';

class DSTextField extends StatefulWidget {
  final String? labelText;
  final IconData? suffixIcon;
  final String? errorText;
  final bool hasError;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final Function()? onSuffixIconTap;
  final String? infoText;
  final Widget? suffix;
  final VoidCallback? onTap;
  final int? maxLength;
  final Function()? onEditingComplete;
  final EdgeInsetsGeometry? margin;
  final Map<String, dynamic>? infoTextParams;
  final Map<String, dynamic>? errorTextParams;
  final bool? enableInteractiveSelection;
  final bool ignoreFocus;
  final Duration delayOnChange;
  final bool debounce;
  final bool autofocus;
  final bool isSmall;
  final bool isSelectRadio;

  DSTextField({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.errorText,
    this.keyboardType,
    this.enabled = true,
    this.onChanged,
    this.onSaved,
    this.inputFormatters,
    this.initialValue,
    this.validator,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.onSuffixIconTap,
    this.infoText,
    this.suffix,
    this.onTap,
    this.readOnly = false,
    this.maxLength,
    this.onEditingComplete,
    this.margin,
    this.infoTextParams,
    this.errorTextParams,
    this.enableInteractiveSelection,
    this.ignoreFocus = false,
    this.delayOnChange = const Duration(milliseconds: 500),
    this.debounce = false,
    this.autofocus = false,
    this.hasError = false,
    this.isSmall = false,
    this.isSelectRadio = false,
  }) : errorTextNotifier = ValueNotifier<String?>(errorText),
       errorPresenceNotifier = ValueNotifier<bool>(
         hasError || (errorText != null && errorText.isNotEmpty),
       ),
       obscureTextNotifier = ValueNotifier(obscureText);

  late final ValueNotifier<String?> errorTextNotifier;
  late final ValueNotifier<bool> errorPresenceNotifier;
  late final ValueNotifier<bool> obscureTextNotifier;

  @override
  State<DSTextField> createState() => _DSTextFieldState();
}

class _DSTextFieldState extends State<DSTextField> {
  Function(String)? get onChanged => widget.onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: widget.errorPresenceNotifier,
            builder:
                (_, error, __) => IgnorePointer(
                  ignoring: widget.ignoreFocus,
                  child: ValueListenableBuilder(
                    valueListenable: widget.obscureTextNotifier,
                    builder: (_, obscureText, __) {
                      return TextFormField(
                        focusNode: widget.focusNode,
                        initialValue: widget.initialValue,
                        controller: widget.controller,
                        readOnly: widget.readOnly,
                        autofocus: widget.autofocus,
                        decoration: InputDecoration(
                          suffixIcon: _showSuffix ?? _showSuffixIcon,
                          label: DSText(
                            widget.labelText ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                          errorMaxLines: 2,
                        ),
                        maxLines: 1,
                        obscureText: obscureText,
                        keyboardType: widget.keyboardType,
                        enabled: widget.enabled,
                        onChanged: (text) => widget.onChanged?.call(text),
                        onSaved: widget.onSaved,
                        onEditingComplete: widget.onEditingComplete,
                        onTap: widget.onTap,
                        inputFormatters: widget.inputFormatters,
                        validator: widget.validator,
                        maxLength: widget.maxLength,
                        enableSuggestions: false,
                        enableInteractiveSelection:
                            widget.enableInteractiveSelection,
                      );
                    },
                  ),
                ),
          ),
          _showErrorTextOrInfoText(textTheme),
        ],
      ),
    );
  }

  Widget? get _showSuffix {
    if (widget.obscureText == true) {
      final obscureTextNotifier = widget.obscureTextNotifier.value;
      return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => widget.obscureTextNotifier.value = !obscureTextNotifier,
        child: Icon(
          obscureTextNotifier
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColors.black40,
          size: 22,
        ),
      );
    }

    if (widget.suffix == null) return null;

    return SizedBox(
      height: Spacing.x6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Flexible(child: widget.suffix!)],
      ),
    );
  }

  Widget? get _showSuffixIcon {
    if (widget.suffixIcon == null) return null;

    return SizedBox(
      height: Spacing.x7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DSIconButton(
            icon: widget.suffixIcon!,
            onTap: widget.onSuffixIconTap ?? widget.onTap,
            width: Spacing.x3,
            margin: EdgeInsets.only(right: Spacing.x0),
          ),
        ],
      ),
    );
  }

  Widget _showErrorTextOrInfoText(TextTheme textTheme) {
    return ValueListenableBuilder<String?>(
      valueListenable: widget.errorTextNotifier,
      builder: (_, errorText, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: errorText != null && errorText.isNotEmpty,
              child: DSText(
                errorText ?? '',
                margin: EdgeInsets.only(top: Spacing.x1),
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.error,
                  height: 1,
                ),
                params: widget.errorTextParams,
              ),
            ),
            Visibility(
              visible: widget.infoText != null,
              child: DSText(
                widget.infoText ?? '',
                margin: EdgeInsets.only(top: Spacing.x1),
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.grey40,
                  height: 1,
                ),
                params: widget.infoTextParams,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    widget.obscureTextNotifier.dispose();
    widget.errorTextNotifier.dispose();
    widget.errorPresenceNotifier.dispose();
    super.dispose();
  }
}
