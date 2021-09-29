import 'dart:ui';
import 'package:flutter/material.dart';

/// Creates a route to the SubBranch page.
class SelectableRouter extends PageRoute {
  SelectableRouter({
    required this.builder,
    RouteSettings? settings,
    Duration? duration,
    Duration? reverseDuration,
    Color? backgroundColor,
    ImageFilter? imageFilter,
    this.curve,
  })  : duration = duration ?? const Duration(milliseconds: 200),
        reverseDuration = duration ?? const Duration(milliseconds: 200),
        backgroundColor = backgroundColor ?? Colors.black.withOpacity(.65),
        imageFilter = imageFilter ?? ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        super(
            settings: settings ??
                const RouteSettings(
                  name: 'page',
                ),
            fullscreenDialog: false);

  /// [Widget] page builder.
  final Widget Function(BuildContext context) builder;

  /// [Duration] animation forward duration.
  final Duration duration;

  /// [Duration] animation reverse duration.
  final Duration reverseDuration;

  /// [Color] background color.
  final Color backgroundColor;

  /// [ImageFilter] background blur.
  /// default value ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0)
  final ImageFilter imageFilter;

  /// A collection of common animation curves.
  /// [Curves.easeInCirc] FadeTransition.
  final Curve? curve;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => backgroundColor;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  Duration get reverseTransitionDuration => reverseDuration;

  @override
  bool get barrierDismissible => true;

  @override
  ImageFilter get filter => imageFilter;

  @override
  void didComplete(result) {
    super.didComplete(result);
  }

  @override
  bool didPop(result) {
    return super.didPop(result);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animation,
          curve: curve ?? Curves.easeInCirc,
        ),
      ),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: builder(context),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
