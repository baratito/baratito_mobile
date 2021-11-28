import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

typedef OnChanged = void Function(String);

class ShoppingListNameInput extends StatefulWidget {
  final String initialText;
  final OnChanged? onChanged;

  const ShoppingListNameInput({
    Key? key,
    required this.initialText,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ShoppingListNameInput> createState() => _ShoppingListNameInputState();
}

class _ShoppingListNameInputState extends State<ShoppingListNameInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration.collapsed(
        hintStyle: context.theme.text.title.copyWith(
          color: context.theme.text.inputPlaceholder.color,
        ),
        hintText: 'shopping.shopping_list'.tr(),
      ),
      onChanged: widget.onChanged,
      maxLines: 2,
      style: context.theme.text.title,
      cursorColor: context.theme.colors.greyAccent,
    );
  }
}
