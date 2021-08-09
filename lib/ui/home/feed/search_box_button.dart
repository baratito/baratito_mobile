import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class SearchBoxButton extends StatelessWidget {
  final String? placeholder;
  final VoidCallback? onPressed;

  const SearchBoxButton({
    Key? key,
    this.placeholder,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final highlightColor =
        context.theme.text.inputPlaceholder.color!.withOpacity(.3);
    final splashColor =
        context.theme.text.inputPlaceholder.color!.withOpacity(.05);
    return Stack(
      children: [
        SearchBox(placeholder: placeholder),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              highlightColor: highlightColor,
              splashColor: splashColor,
              onTap: onPressed,
            ),
          ),
        )
      ],
    );
  }
}
