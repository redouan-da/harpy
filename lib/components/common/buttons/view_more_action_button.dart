import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harpy/components/common/buttons/harpy_button.dart';
import 'package:harpy/components/common/misc/modal_sheet_handle.dart';
import 'package:harpy/core/theme/harpy_theme.dart';

/// Builds a button that opens a modal bottom sheet with the [children] in a
/// column.
class ViewMoreActionButton extends StatelessWidget {
  const ViewMoreActionButton({
    @required this.children,
    this.padding = const EdgeInsets.all(16),
    this.sizeDelta = 0,
  });

  final List<Widget> children;
  final EdgeInsets padding;
  final double sizeDelta;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return HarpyButton.flat(
      icon: Icon(
        CupertinoIcons.ellipsis_vertical,
        size: theme.iconTheme.size + sizeDelta,
      ),
      padding: padding,
      onTap: () => showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: kDefaultRadius,
            topRight: kDefaultRadius,
          ),
        ),
        builder: (BuildContext context) => SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ModalSheetHandle(),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
