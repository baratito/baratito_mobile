import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class BottomSheetBase extends StatelessWidget {
  final String? title;
  final Widget child;

  const BottomSheetBase({
    Key? key,
    required this.child,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(32);
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        borderRadius: const BorderRadius.only(
          topLeft: radius,
          topRight: radius,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildDragLine(context),
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
        color: context.theme.colors.greyAccent,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title!,
            style: context.theme.text.headline1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
