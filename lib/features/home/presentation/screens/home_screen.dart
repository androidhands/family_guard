import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Center(
        child: CustomText(
          tr(AppConstants.welcome),
          textStyle: Theme.of(context).textTheme.displayLarge!,
        ),
      ),
    );
  }
}
