import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  /// A [Widget] to be shown at the beggining of the AppBar.
  ///
  /// It defaults to a back button when not present.
  final Widget? leading;

  final List<Widget>? actions;

  const MainAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensionTheme = context.theme.dimensions as MobileDimensionTheme;
    final horizontalPadding = dimensionTheme.appBarHorizontalPadding;
    final leftPadding =
        leading != null ? horizontalPadding : horizontalPadding / 2;

    return Container(
      color: context.theme.colors.background,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: context.responsive(horizontalPadding, axis: Axis.horizontal),
            left: context.responsive(leftPadding, axis: Axis.horizontal),
          ),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final showActions = actions != null && actions!.isNotEmpty;
    return Stack(
      alignment: Alignment.center,
      children: [
        if (title != null) Row(children: [_buildTitle(context)]),
        Row(
          mainAxisAlignment: showActions
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            _buildLeading(context),
            if (showActions) _buildActions(context),
          ],
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        for (final action in actions!)
          Padding(
            padding: EdgeInsets.only(
              right: context.responsive(8, axis: Axis.horizontal),
            ),
            child: action,
          ),
      ],
    );
  }

  Widget _buildLeading(BuildContext context) {
    if (leading != null) return leading!;
    final color = context.theme.colors.iconAction;
    final highlightRadius = BorderRadius.circular(20);
    return Material(
      borderRadius: highlightRadius,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: highlightRadius,
        highlightColor: color.withOpacity(.2),
        splashColor: color.withOpacity(.05),
        onTap: context.popView,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(
            context.isIos ? Icons.arrow_back_ios_new : Icons.arrow_back,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Expanded(
      child: Text(
        title!,
        style: context.theme.text.headline1,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
