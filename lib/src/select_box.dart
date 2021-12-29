import 'dart:ui';
import 'package:flutter/material.dart';
import 'select_action.dart';
import 'selectable.dart';

class Select<T> extends State<Selectable<T>>
    with SingleTickerProviderStateMixin {
  /// Header animations.
  late AnimationController _animationController;

  List<T> get _model => widget.parentList;

  List<dynamic> _innerModel(T model) => widget.childList.call(model);

  int _innerLength(T model) => _innerModel(model).length;

  int get _modelLength => _model.length;

  BuilderSelect get _builder => widget.builder;

  BuilderInnerSelect get _innerBuilder => widget.childBuilder;

  late int selectedItem;

  late List<int> selectedInnerItems;

  @override
  void initState() {
    selectedInnerItems = widget.selectedList;
    _loadAnimation();
    super.initState();
  }

  void _loadAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  /// entry animation of headers.
  Animation<double> animScale(int index) => CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          1.0 - index / _modelLength / 2.0,
          curve: Curves.easeOut,
        ),
      );

  /// seçili model id ve seçili olup olmadığını döndürür.
  void _onSelected(int selectId, bool isSelected) {
    widget.onSelect.call(selectId, isSelected);
    setState(() {});
  }

  /// Router detail screen
  /// inner selected.
  void onDetail(int modelIndex) {
    selectedItem = modelIndex;
    Navigator.push(
      context,
      _createRoute(
        _MultiSelectDetailScreen(
          heroTag: modelIndex,
          model: _model[modelIndex],
          header: _builder.call(context, _model[modelIndex], false),
          innerSelect: _innerBuilder,
          innerModel: _innerModel(_model[modelIndex]),
          selected: selectedInnerItems,
          onSelect: _onSelected,
          closeButton: widget.closeButton,
          filter: widget.imageFilter,
        ),
        widget.backgroundColor,
      ),
    );
  }

  /// Check inner any selected.
  bool checkSelect(T model) {
    for (var i = 0; i < _innerLength(model); i++) {
      final check = selectedInnerItems.any(
        (element) => element == getId(model, i),
      );
      if (check) return true;
    }
    return false;
  }

  /// [Object] or [Map] check controller..
  int getId(T model, int innerItemIndex) {
    final inner = _innerModel(model)[innerItemIndex];
    if (inner is Map) return inner["id"];
    return inner.id;
  }

  @override
  Widget build(BuildContext context) {
    return SelectableScope(
      state: this,
      child: Material(
        color: Colors.transparent,
        child: GridView.builder(
          padding: widget.padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: widget.crossAxisSpacing,
              childAspectRatio: widget.childAspectRatio,
              mainAxisSpacing: widget.mainAxisSpacing,
              mainAxisExtent: widget.mainAxisExtent),
          itemCount: _model.length,
          itemBuilder: (context, index) {
            return ScaleTransition(
              scale: animScale(index),
              child: Hero(
                tag: index,
                child: buildParentItem(context, _model[index], index),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildParentItem(context, model, index) {
    return GestureDetector(
      onTap: () => onDetail(index),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _builder.call(context, _model[index], checkSelect(model)),
          _buildCheckIcon(model),
        ],
      ),
    );
  }

  Widget _buildCheckIcon(T model) {
    return checkSelect(model)
        ? Positioned(
            right: 0.0,
            top: 3.0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..translate(4.0, -10.0),
              child: widget.icon ??
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.done, color: Colors.white),
                  ),
            ),
          )
        : const SizedBox.shrink();
  }
}

/// Animated [Router].
Route _createRoute(Widget widget, Color? backgroundColor) => PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: widget,
      ),
      opaque: false,
      barrierDismissible: true,
      barrierColor: backgroundColor,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.linear),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    );

/// Multi selection detail screen will be opened with this widget.
/// With this page, you will be able to make multiple selections of your selected model.
class _MultiSelectDetailScreen extends StatefulWidget {
  const _MultiSelectDetailScreen({
    Key? key,
    required this.header,
    required this.model,
    required this.heroTag,
    required this.innerSelect,
    required this.innerModel,
    required this.selected,
    required this.onSelect,
    required this.filter,
    Widget? closeButton,
  })  : closeButton = closeButton ?? const SizedBox(),
        super(key: key);
  final Widget header;
  final dynamic model;
  final int heroTag;
  final BuilderInnerSelect innerSelect;
  final List<dynamic> innerModel;
  final List<int> selected;
  final Function(int id, bool isSelected) onSelect;
  final Widget closeButton;
  final ImageFilter filter;

  @override
  State<_MultiSelectDetailScreen> createState() => _MultiSelect();
}

class _MultiSelect extends State<_MultiSelectDetailScreen> {
  late List<int> selectedInnerItem;

  @override
  void initState() {
    selectedInnerItem = widget.selected;
    super.initState();
  }

  bool _checkSelect(int index) {
    return selectedInnerItem.any((element) => element == _getId(index));
  }

  int _getId(int index) {
    final inner = widget.innerModel[index];
    if (inner is Map) return inner["id"];
    return inner.id;
  }

  void _onSelect(int index) {
    final selectedId = _getId(index);
    bool isSelected = selectedInnerItem.any((element) => element == selectedId);
    if (isSelected) {
      selectedInnerItem.remove(selectedId);
    } else {
      selectedInnerItem.add(selectedId);
    }
    widget.onSelect.call(selectedId, !isSelected);
    setState(() {});
  }

  SelectableChild innerSelect(int index) => widget.innerSelect
      .call(context, widget.innerModel, index, _checkSelect(index));

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(top: 40.0),
          child: ClipRRect(
            child: BackdropFilter(
              filter: widget.filter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(children: [_buildParent, buildChildList]),
                  Positioned(bottom: 10.0, child: widget.closeButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildParent {
    return Flexible(
      child: FractionallySizedBox(
        heightFactor: .55,
        widthFactor: .55,
        child: Hero(
          tag: widget.heroTag,
          child: widget.header,
        ),
      ),
    );
  }

  Widget get buildChildList {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 20.0),
          itemCount: widget.innerModel.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final builder = innerSelect(index);
            return buildChildItem(index, builder);
          },
        ),
      ),
    );
  }

  GestureDetector buildChildItem(int index, SelectableChild builder) {
    return GestureDetector(onTap: () => _onSelect(index), child: builder);
  }
}
