import 'package:flutter/material.dart';

const Color _selectedColor = Colors.green;

abstract class SelectAction extends StatelessWidget {
  const SelectAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: builder(context),
    );
  }

  @protected
  Widget builder(BuildContext context);
}

/// The header that will represent your multiple selections
/// you can add [title].
/// You can add [child] and customize it.
/// can return selected by adding [icon].
/// You can customize it by adding [decoration].
// ignore: must_be_immutable
class SelectableParent extends SelectAction {
  SelectableParent({
    Key? key,
    required this.child,
    this.title,
    Color? color,
    Decoration? decoration,
  })  : assert(decoration == null || decoration.debugAssertIsValid()),
        assert(
          color == null || decoration == null,
          'Cannot provide both a color and a decoration\n'
          'The color argument is just a shorthand for\n'
          "decoration: BoxDecoration(color: color ?? Colors.blue,shape:BoxShape.circle).",
        ),
        decoration =
            decoration ?? BoxDecoration(color: color ?? Colors.transparent),
        super(key: key);

  /// It will appear above the header.
  /// and together with title represent your multiple selections.
  final Widget child;

  /// The title of your multi-select list.
  /// and represents your multiple selections, such as header.
  final Widget? title;

  /// This is the decoration of the container attached to [child].
  /// default value is `BoxDecoration(color:color)`
  final Decoration? decoration;

  @override
  Widget builder(BuildContext context) {
    Widget? buildChild;
    if (title != null) {
      buildChild = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Container(decoration: decoration, child: child)),
          title!,
        ],
      );
    } else {
      buildChild = Container(decoration: decoration, child: child);
    }
    return buildChild;
  }
}

/// The mutli selection feature is provided with this class..
/// [child] is the content of the page to redirect after onTap.
/// It has features such as being selectable and rotating the selected one..
/// [leading] widget to be in the header.
/// [title] leading widget.
/// Can be customized with [decoration].
class SelectableChild extends SelectAction {
  const SelectableChild({
    Key? key,
    required this.selected,
    this.leading,
    this.title,
    this.suffixIcon,
    double? borderRadius,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? color,
    Color? selectedColor,
  })  : color = color ?? Colors.white,
        selectedColor = selectedColor ?? _selectedColor,
        borderRadius = borderRadius ?? 10.0,
        margin = margin ?? const EdgeInsets.all(5.0),
        padding = padding ?? const EdgeInsets.all(5.0),
        super(key: key);

  /// If selected return of builder
  /// put in here. [selected].
  final bool selected;

  /// It finds a [Widget] in the header.
  final Widget? leading;

  /// Content olarak [title] [Widget] verilir.
  final Widget? title;

  /// The contain radius.
  /// default [10.0]
  final double borderRadius;

  /// Shown if selected at the end of all.
  final Widget? suffixIcon;

  /// [Padding] of this [inner]
  final EdgeInsets padding;

  /// [Margin] of this inner
  final EdgeInsets margin;

  /// [Color] of contain.
  final Color color;

  /// Selected contain color.
  final Color selectedColor;

  @override
  Widget builder(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: selected ? selectedColor : color,
      ),
      child: Row(children: buildChildDetails),
    );
  }

  List<Widget> get buildChildDetails {
    Widget lead = Visibility(
      visible: leading != null,
      child: Container(child: leading),
    );

    Widget suffix = Visibility(
      visible: suffixIcon != null,
      child: Opacity(
        opacity: selected ? 1.0 : 0.0,
        child: Container(child: suffixIcon),
      ),
    );

    Widget tit = Expanded(
      child: Visibility(
        visible: title != null,
        child: Container(
          child: title,
          margin: const EdgeInsets.only(left: 4.0),
        ),
      ),
    );

    return [lead, tit, suffix];
  }
}
