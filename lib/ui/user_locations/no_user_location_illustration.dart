import 'package:baratito_mobile/configs/configs.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoUserLocationIllustration extends StatelessWidget {
  const NoUserLocationIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkmodeActive = context.isDarkmodeActive;
    final illustration = isDarkmodeActive
        ? Illustrations.noUserLocationDark
        : Illustrations.noUserLocationLight;
    return SvgPicture.asset(illustration, width: 200);
  }
}
