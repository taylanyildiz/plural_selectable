import 'dart:ui';
import 'package:flutter/material.dart';

import 'router.dart';
import 'selectable_action.dart';
import 'selectable_sub.dart';

/// [typedef] Function for SubBranches.
typedef SubBranchBuilder = Subs Function(
    BuildContext context, int branchIndex, int subIndex);

class Subs {
  Subs({
    required this.leading,
    required this.title,
  });
  final Widget leading;
  final String title;
}

/// [typedef] Function for SubBranches.
typedef BranchBuilder = Widget Function(BuildContext context, int index);

abstract class BranchActionDelegate<T> {
  /// Constructor [BranchActionDelegate].
  const BranchActionDelegate();

  /// Action return the model
  List<T> build(int index);
}

abstract class SubBranchActionDelegate<T> {
  /// Constructor [SubBranchActionDelegate].
  const SubBranchActionDelegate();

  /// Return subBranches [Widget].
  Subs build(BuildContext context, int branchIndex, int subIndex);
}

class SubBranchActionBuilderDelegate extends SubBranchActionDelegate {
  SubBranchActionBuilderDelegate({
    required this.builder,
    required this.selected,
  });

  /// Called to build remove actions.
  ///
  /// Will be called only for indices greater than or equal to zero and less
  /// than [childCount].
  final SubBranchBuilder builder;

  /// [List] selected value of items.
  final List<bool> Function(int index) selected;

  @override
  Subs build(BuildContext context, int branchIndex, int subIndex) =>
      builder(context, branchIndex, subIndex);
}

class _SelectableScope extends InheritedWidget {
  const _SelectableScope({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  final SelectableState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      (oldWidget as _SelectableScope).state != state;
}

class Selectable<T> extends StatefulWidget {
  const Selectable({
    Key? key,
    required this.onSelection,
    required this.branchCount,
    required this.subBranches,
    required this.branchChild,
    required this.title,
    this.imageFilter,
    this.crossAxisSpacing = 5.0,
    this.mainAxisSpacing = 0.0,
    this.childAspectRatio = 0.75,
    this.maxCrossAxisExtent = 200.0,
    this.duration = const Duration(milliseconds: 750),
    this.transtionDuration = const Duration(milliseconds: 500),
    this.activeColor,
    this.deactiveColor,
    this.decoration,
    this.titleActiveStyle,
    this.titleDeactiveStyle,
    this.titleStyle,
    this.curve,
    this.reverseDuration,
    this.backgroundColor,
    this.backButton,
    this.checkBackground,
    this.checkIconColor,
    this.titleBackButton,
    this.checkedIconColor,
    this.selectedBackgroundColor,
  }) : super(key: key);

  /// OnPress [Function] selection
  final Function(int branch, int sub, bool checked) onSelection;

  /// Branches return model.
  final int branchCount;

  /// Branches title. Botttom of branch child.
  final String Function(int branch) title;

  /// Skeleton of Branches [Widget] child.
  final BranchBuilder branchChild;

  /// [SubBranchActionDelegate] subBranches.
  final SubBranchActionBuilderDelegate subBranches;

  /// A collection of common animation curves.
  /// [Curves.easeInCirc] FadeTransition.
  final Curve? curve;

  /// Entry create animation duration
  final Duration duration;

  /// [Color] background color. SubBranches selection screen.
  final Color? backgroundColor;

  /// SubBranch page transition animation time
  final Duration transtionDuration;

  /// [Duration] animation reverse duration.
  final Duration? reverseDuration;

  /// Background blur of the SubBranch page.
  final ImageFilter? imageFilter;

  /// The distance between branches is horizontal.
  /// default value is 5.0
  final double crossAxisSpacing;

  /// The distance between branches is vertical.
  /// default value is 0.0
  final double mainAxisSpacing;

  /// The ratio of the cross-axis to the main-axis extent of each child.
  final double childAspectRatio;

  /// The maximum extent of tiles in the cross axis.
  ///
  /// This delegate will select a cross-axis extent for the tiles that is as
  /// large as possible subject to the following conditions:
  ///
  ///  - The extent evenly divides the cross-axis extent of the grid.
  ///  - The extent is at most [maxCrossAxisExtent].
  ///
  /// For example, if the grid is vertical, the grid is 500.0 pixels wide, and
  /// [maxCrossAxisExtent] is 150.0, this delegate will create a grid with 4
  /// columns that are 125.0 pixels wide.
  final double maxCrossAxisExtent;

  /// Unselected background color.
  final Color? deactiveColor;

  /// Selected background color.
  final Color? activeColor;

  /// Selected Title style.
  final TextStyle? titleActiveStyle;

  /// Unselected title style.
  final TextStyle? titleDeactiveStyle;

  /// Background box decoration.
  final BoxDecoration? decoration;

  /// Title [TextStyle]
  final TextStyle? titleStyle;

  /// [Widget] backbutton.
  final Widget? backButton;

  /// [String] title of back button.
  final String? titleBackButton;

  /// [Color] of checked background.
  final Color? checkBackground;

  /// [Color] of checked icon color.
  final Color? checkIconColor;

  /// Color circle background.
  final Color? selectedBackgroundColor;

  /// Icon color circle icon checked.
  final Color? checkedIconColor;

  static SelectableState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_SelectableScope>()?.state;

  @override
  State<Selectable> createState() => SelectableState();
}

class SelectableState<T> extends State<Selectable>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<Selectable> {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Selectable oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  int get _branchesCount => widget.branchCount;

  SubBranchActionBuilderDelegate get _subBranchActionDelegate =>
      widget.subBranches;

  int _subBranchCount(index) =>
      _subBranchActionDelegate.selected.call(index).length;

  double anim(int index) => Tween<double>(begin: 0.0, end: 1.0)
      .animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            1 / _branchesCount * index,
            (1 / _branchesCount * index) + 1 / _branchesCount,
            curve: Curves.elasticOut,
          ),
        ),
      )
      .value;

  bool _getSelectedBrach(index) =>
      widget.subBranches.selected(index).any((element) => element);

  List<Subs> generateSubs(context, branchIndex) => List.generate(
        _subBranchCount(branchIndex),
        (subIndex) =>
            widget.subBranches.builder.call(context, branchIndex, subIndex),
      );

  void selectItem(BuildContext context, int index) {
    Navigator.push(
      context,
      SelectableRouter(
        builder: (context) => SelectableSub(
          subs: generateSubs(context, index),
          onSelection: (sub, checked) => selection(index, sub, checked),
          heroTag: index,
          selected: widget.subBranches.selected.call(index),
          child: BranchItem(
            child: widget.branchChild.call(context, index),
            index: index,
          ),
          deactiveColor: widget.deactiveColor,
          activeColor: widget.activeColor,
          decoration: widget.decoration,
          titleActiveStyle: widget.titleActiveStyle,
          titleDeactiveStyle: widget.titleDeactiveStyle,
          backButton: widget.backButton,
          checkBackground: widget.checkBackground,
          checkIconColor: widget.checkIconColor,
          titleBackButton: widget.titleBackButton,
        ),
        duration: widget.transtionDuration,
        imageFilter: widget.imageFilter,
        reverseDuration: widget.reverseDuration,
        backgroundColor: widget.backgroundColor,
        curve: widget.curve,
      ),
    );
  }

  void selection(int branch, int sub, bool checked) {
    widget.onSelection.call(branch, sub, checked);
  }

  GridView get buildGridView => GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: widget.maxCrossAxisExtent,
          crossAxisSpacing: widget.crossAxisSpacing,
          mainAxisSpacing: widget.mainAxisSpacing,
          childAspectRatio: widget.childAspectRatio,
        ),
        itemCount: _branchesCount,
        itemBuilder: (context, index) => branchesBuilder(context, index),
      );

  Widget branchesBuilder(BuildContext context, int index) => Hero(
        tag: index,
        child: animatedBranchHeader(index),
      );

  Widget animatedBranchHeader(int index) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(anim(index)),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(flex: 4, child: branchesChild(context, index)),
              Expanded(child: title(index)),
            ],
          ),
        ),
      );

  Widget branchesChild(context, index) => BranchItem(
        child: widget.branchChild.call(context, index),
        index: index,
        isSlected: _getSelectedBrach(index),
        checkedIconColor: widget.activeColor,
        selectedBackgroundColor: widget.activeColor,
      );

  Widget title(index) => Text(
        widget.title.call(index),
        style: widget.titleStyle ??
            const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
      );

  @override
  Widget build(BuildContext context) {
    return _SelectableScope(
      state: this,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => buildGridView,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
