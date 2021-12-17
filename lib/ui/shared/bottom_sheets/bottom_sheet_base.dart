import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class BottomSheetBase extends StatelessWidget {
  final String? title;
  final BorderRadius? borderRadius;
  final bool showDragLine;
  final Widget child;

  const BottomSheetBase({
    Key? key,
    required this.child,
    this.title,
    this.borderRadius,
    this.showDragLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultRadius = Radius.circular(32);
    const defaultBorderRadius = BorderRadius.only(
      topLeft: defaultRadius,
      topRight: defaultRadius,
    );
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        borderRadius: borderRadius ?? defaultBorderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (showDragLine) _buildDragLine(context),
          if (title != null) _buildTitle(context),
          child,
        ],
      ),
    );
  }

  Widget _buildDragLine(BuildContext context) {
    final width = context.screenSize.width * 0.2;
    const height = 4.0;
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: context.theme.colors.dragLine,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TextOneLine(
              title!,
              style: context.theme.text.headline1,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
