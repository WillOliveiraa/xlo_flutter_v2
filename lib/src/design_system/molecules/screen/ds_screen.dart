import 'package:flutter/material.dart';

class DSScreen extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  // final Widget? drawer;
  // final Widget? endDrawer;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry? padding;
  final GlobalKey? scaffoldKey;
  final bool hasBodyExtent;
  final bool hasScrollBody;
  final ScrollPhysics? scrollPhysics;
  // final FloatingActionButtonLocation? floatingActionButtonLocation;
  final ScrollController? scrollController;
  // final Color? drawerScrimColor;
  final bool canPop;
  final bool safeAreaBottom;
  // final UiOverlayStyle? uiOverlayStyle;

  const DSScreen({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    // this.drawer,
    // this.endDrawer,
    this.floatingActionButton,
    this.padding,
    this.scaffoldKey,
    this.hasBodyExtent = true,
    this.hasScrollBody = true,
    this.scrollPhysics,
    // this.floatingActionButtonLocation,
    this.scrollController,
    // this.drawerScrimColor,
    this.canPop = true,
    this.safeAreaBottom = true,
    // this.uiOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (appBar == null) {
      return WillPopScope(
        onWillPop: () async => canPop,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: backgroundColor,
            appBar: appBar,
            body: SafeArea(bottom: safeAreaBottom, child: _resolveBody),
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => canPop,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: backgroundColor,
          appBar: appBar,
          body: SafeArea(bottom: safeAreaBottom, child: _resolveBody),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }

  Widget get _resolveBody {
    if (!hasScrollBody) {
      return Padding(padding: padding ?? const EdgeInsets.all(0), child: body);
    } else if (hasBodyExtent) {
      return LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            physics: scrollPhysics,
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight,
                minWidth: constraint.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: padding ?? const EdgeInsets.all(0),
                  child: body,
                ),
              ),
            ),
          );
        },
      );
    } else {
      return SingleChildScrollView(
        physics: scrollPhysics,
        controller: scrollController,
        padding: padding,
        child: body,
      );
    }
  }
}
