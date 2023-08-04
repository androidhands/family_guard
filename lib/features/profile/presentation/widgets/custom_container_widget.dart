import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';

class CustomContainerWidget extends StatelessWidget {
  final List<Widget> children;

  const CustomContainerWidget({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppSizes.widthFullScreen,
        alignment: AlignmentDirectional.topStart,
        margin: EdgeInsets.only(top: AppSizes.pH3, bottom: AppSizes.pH5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppSizes.br12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pW5,
          vertical: AppSizes.pH7,
        ),
        child: Column(
          children: children,
        ));
  }
}
