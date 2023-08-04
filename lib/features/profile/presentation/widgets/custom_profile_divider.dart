import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';

class CustomProfileDivider extends StatelessWidget {
  const CustomProfileDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: AppSizes.pH7,
    );
  }
}
