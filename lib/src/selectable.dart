import 'dart:ui';
import 'package:flutter/material.dart';
import 'select_action.dart';
import 'select_box.dart';

/// By dint of this [InheritedWidget] class [selectActions] will will rest.
class SelectableScope extends InheritedWidget {
  const SelectableScope({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);
  final Select state;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as SelectableScope).state != state;
  }
}

/// [child] builder.
typedef BuilderSelect = SelectableParent Function(
    BuildContext context, dynamic model, bool isSelected);

/// [innerSelect] builder.
/// this model is not your orginal model.
/// it returns the model you choose
typedef BuilderInnerSelect = SelectableChild Function(
    BuildContext context, List<dynamic> inner, int index, bool isSelected);

/// If the model type in it is written,the search becomes easeir.
class Selectable<T> extends StatefulWidget {
  /// List model.
  ///  The desired variable of this model will be returned as
  /// [Widget] and you will be able to select it.
  final List<T> parentList;

  /// This model list is the model list you will choose from your original model.
  final List<dynamic> Function(T model) childList;

  /// By dint of this [builder]
  /// you will be able to choose your title and add the widget you want to these titles.
  final BuilderSelect builder;

  /// It will indicate which variable from your model your multi-select list depends on.
  /// this structure has to show a list structure inside your model.
  /// Inside the list structure there must be a variable
  /// [id] that allows it to be specifically parsed from the others
  ///  [id] each element must hold a different [int] value from the others.
  final BuilderInnerSelect childBuilder;

  /// This method returns the id of the model
  /// you have selected and whether it is selected.
  final Function(int id, bool isSelect) onSelect;

  /// This list is inside your model if you have a pre-selected structure.
  /// You are expected to specify the selected ones.
  final List<int> selectedList;

  /// You can make it functional by putting the back button. This button can be anywhere you want.
  /// You can add [Positioned].
  /// It has no default location, you must specify it. The button is only visible on the detail screen.
  final Widget? closeButton;

  /// Background blur of the detail page.
  /// 4.0 - 4.0
  final ImageFilter imageFilter;

  /// [Color] background color of detail page.
  /// default `Colors.black.withOpacity(.65)`
  final Color backgroundColor;

  /// Padding of headers.
  /// default const EdgeInsets.all(10.0),
  final EdgeInsets padding;

  /// If an item under this heading is selected
  /// [icon] will appear.
  /// its default value is `Icon(Icons.done,color:Colors.white)`
  final Widget? icon;

  /// The distance between branches is horizontal.
  /// default value is 5.0
  final double crossAxisSpacing;

  /// The distance between branches is vertical.
  /// default value is 4.0
  final double mainAxisSpacing;

  /// The grid view mainAxisExtent
  final double? mainAxisExtent;

  /// The ratio of the cross-axis to the main-axis extent of each child.
  /// default `1/1`
  final double childAspectRatio;

  /// The number of children in the cross axis.
  /// default value 2 [int].
  final int crossAxisCount;

  /// You must define a model required for multiple selection
  /// This model can be any way you want.
  /// The only thing required is to have a variable in this model that can tell if it is selected or not.
  /// this variable must be [id]. You can define a [Map] or create an [Object].
  /// If you have created a map, don't forget to add `{"id" : "--"}` in it
  /// If this variable is not found, the widget returns an error.
  Selectable({
    Key? key,
    required this.parentList,
    required this.childList,
    required this.builder,
    required this.onSelect,
    required this.childBuilder,
    required this.selectedList,
    this.icon,
    this.closeButton,
    this.mainAxisExtent,
    ImageFilter? imageFilter,
    Color? backgroundColor,
    EdgeInsets? headerPadding,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    double? childAspectRatio,
    double? maxCrossAxisExtent,
    int? crossAxisCount,
  })  : imageFilter = imageFilter ?? ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        backgroundColor = backgroundColor ?? Colors.black.withOpacity(.65),
        padding = headerPadding ?? const EdgeInsets.all(10.0),
        crossAxisSpacing = crossAxisSpacing ?? 5.0,
        mainAxisSpacing = mainAxisSpacing ?? 4.0,
        childAspectRatio = childAspectRatio ?? (1 / 1),
        crossAxisCount = crossAxisCount ?? 2,
        super(key: key);

  /// Sayfa geçişi ve çoklu seçimleri dinleyebilmek için
  /// Inherited widget.
  static Select? of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SelectableScope>();
    return scope?.state;
  }

  @override
  State<StatefulWidget> createState() => Select<T>();
}
