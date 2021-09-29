// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'selectable.dart';

abstract class SelectableAction extends StatelessWidget {
  /// Constructor [SelectableAction].
  const SelectableAction({
    required this.isSlected,
    required this.index,
    this.checkedIconColor,
    this.selectedBackgroundColor,
  });

  /// Which item onPress calling.
  final int index;

  /// If any of Branch's SubBranch is true, it will also return true here.
  final bool isSlected;

  /// Color circle background.
  final Color? selectedBackgroundColor;

  /// Icon color circle icon checked.
  final Color? checkedIconColor;

  void _selectItem(int index, BuildContext context) {
    if (Selectable.of(context) != null) {
      Selectable.of(context)?.selectItem(context, index);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectItem(index, context),
      child: Stack(
        children: [
          builder(context),
          buildCheck,
        ],
      ),
    );
  }

  Widget get buildCheck => isSlected
      ? Positioned(
          top: 10.0,
          right: 0.0,
          child: Container(
            height: 35.0,
            width: 35.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: const Center(
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 27.0,
              ),
            ),
          ),
        )
      : const SizedBox();

  @protected
  Widget builder(BuildContext context);
}

class BranchItem extends SelectableAction {
  /// [BranchItem] Constructor.
  const BranchItem({
    required this.child,
    required this.index,
    this.isSlected = false,
  }) : super(
          index: index,
          isSlected: isSlected,
        );

  /// Hagi Branch'in tıklandığını anlamamız için gerekli
  final int index;

  /// Which item is selectected or selected in have subItems.
  final bool isSlected;

  /// Bu widget'in içinde olacak widget.
  final Widget child;

  @override
  Widget builder(BuildContext context) => child;
}
