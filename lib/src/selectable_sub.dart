import 'package:flutter/material.dart';
import 'selectable.dart';

class _SelectableSubScope extends InheritedWidget {
  const _SelectableSubScope({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);
  final SelectableSubState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as _SelectableSubScope).state != state;
  }
}

class SelectableSub extends StatefulWidget {
  const SelectableSub({
    Key? key,
    this.subs,
    required this.onSelection,
    required this.child,
    required this.heroTag,
    required this.selected,
    this.activeColor,
    this.deactiveColor,
    this.decoration,
    this.titleActiveStyle,
    this.titleDeactiveStyle,
    this.backButton,
    this.checkBackground,
    this.checkIconColor,
    this.titleBackButton,
  }) : super(key: key);

  /// [Hero] animation tag.
  final int heroTag;

  /// [Widget] child of header subBranch.
  final Widget child;

  final List<Subs>? subs;

  /// Selected value of items.
  final List<bool> selected;

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

  /// return value of which subBranches selection
  final Function(int subIndex, bool checked) onSelection;

  /// [Widget] backbutton.
  final Widget? backButton;

  /// [String] title of back button.
  final String? titleBackButton;

  /// [Color] of checked background.
  final Color? checkBackground;

  /// [Color] of checked icon color.
  final Color? checkIconColor;

  static SelectableSubState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_SelectableSubScope>()!.state;

  @override
  State<SelectableSub> createState() => SelectableSubState();
}

class SelectableSubState<T> extends State<SelectableSub> {
  List<bool> _selectedItem = [];

  @override
  void initState() {
    _selectedItem = widget.selected;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SelectableSub oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void onSelection(int index) {
    _selectedItem[index] = !_selectedItem[index];
    widget.onSelection(index, _selectedItem[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _SelectableSubScope(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              selectableHeaderContain(context),
              buildBackButton(context),
            ],
          ),
        ),
      ),
      state: this,
    );
  }

  GestureDetector buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: widget.backButton ??
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black54,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 25.0,
            ),
            child: Material(
              color: Colors.transparent,
              child: Text(
                widget.titleBackButton ?? 'Back',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
    );
  }

  Column selectableHeaderContain(context) {
    return Column(
      children: [
        Expanded(
          child: Hero(
            tag: widget.heroTag,
            child: Material(
              color: Colors.transparent,
              child: widget.child,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: List.generate(
                widget.selected.length,
                (index) => GestureDetector(
                  onTap: () => onSelection(index),
                  child: subBrancheContain(index),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AnimatedContainer subBrancheContain(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: widget.decoration ??
          BoxDecoration(
            color: _selectedItem[index]
                ? widget.activeColor ?? Colors.green
                : widget.deactiveColor ?? Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        children: [
          Material(
              color: Colors.transparent,
              child: widget.subs?[index].leading ?? const SizedBox()),
          const SizedBox(width: 5.0),
          Expanded(
            child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.subs![index].title,
                  style: _selectedItem[index]
                      ? widget.titleActiveStyle
                      : widget.titleDeactiveStyle,
                )),
          ),
          circleChecBoxContainer(index),
        ],
      ),
    );
  }

  AnimatedContainer circleChecBoxContainer(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _selectedItem[index] ? Colors.blue : Colors.white,
      ),
      padding: const EdgeInsets.all(5.0),
      child: const Icon(
        Icons.done,
        color: Colors.white,
        size: 26.0,
      ),
    );
  }
}
