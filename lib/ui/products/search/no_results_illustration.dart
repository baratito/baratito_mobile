import 'package:baratito_mobile/configs/configs.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoResultsIllustration extends StatelessWidget {
  const NoResultsIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkmodeActive = context.isDarkmodeActive;
    final illustration = isDarkmodeActive
        ? Illustrations.productsNoResultsDark
        : Illustrations.productsNoResultsLight;
    return SvgPicture.asset(illustration, width: 200);
  }
}
