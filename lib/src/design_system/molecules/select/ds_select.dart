import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/design_system/atoms/divider/ds_divider.dart';
import 'package:xlo_flutter_v2/src/design_system/molecules/text_field/ds_text_field.dart';

class DSSelect extends StatefulWidget {
  final List<String> children;
  final String? value;
  final String? label;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const DSSelect({
    super.key,
    this.children = const [],
    this.value,
    this.label,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.margin,
    this.controller,
    this.focusNode,
    this.readOnly = false,
  });

  @override
  State<DSSelect> createState() => _DSSelectState();
}

class _DSSelectState extends State<DSSelect>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final TextEditingController controller;
  late final FocusNode focusNode;
  bool hasFocus = true;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.value);
    focusNode = widget.focusNode ?? FocusNode();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      upperBound: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DSTextField(
      labelText: widget.label,
      suffix:
          widget.readOnly
              ? null
              : RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.primaryText,
                ),
              ),
      controller: controller,
      focusNode: hasFocus ? focusNode : null,
      readOnly: true,
      onChanged: widget.onChanged,
      validator: widget.validator,
      enabled: widget.enabled,
      margin: widget.margin,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        animationController.forward(from: 0.0);
        setState(() => hasFocus = false);

        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 36),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.children.length,
                separatorBuilder:
                    (_, __) => DSDivider.small(color: AppColors.borderColor),
                itemBuilder:
                    (_, index) => InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.text = widget.children[index];
                        widget.onChanged?.call(widget.children[index]);
                      },
                      child: SizedBox(
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.children[index],
                                          style: TextTheme.of(
                                            context,
                                          ).labelMedium?.copyWith(
                                            color: AppColors.primaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 24,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            );
          },
        );

        _onClose();
      },
    );
  }

  void _onClose() {
    setState(() => hasFocus = true);
    animationController.reverse(from: 0.5);
    focusNode.requestFocus();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    if (widget.focusNode == null) focusNode.dispose();
    animationController.dispose();
    super.dispose();
  }
}
