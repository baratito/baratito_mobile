import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class ProductDetailTitle extends StatelessWidget {
  final Product product;

  const ProductDetailTitle({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                product.name,
                style: context.theme.text.headline1,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(4)),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  product.presentation,
                  style: context.theme.text.body,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
