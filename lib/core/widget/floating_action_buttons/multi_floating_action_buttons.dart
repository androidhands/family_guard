import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';

import 'multi_floating_buttons/flutter_speed_dial.dart';

class MultiFloatingActionButtons extends StatelessWidget {
  final String iconAsset;
  final List<SpeedDialChild> floatingButtons;

  const MultiFloatingActionButtons(
      {Key? key, required this.iconAsset, required this.floatingButtons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      iconAsset: iconAsset,
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: ThemeColorLight.pinkColor,
      visible: true,
      curve: Curves.bounceIn,
      children: floatingButtons,
    );
  }
}
