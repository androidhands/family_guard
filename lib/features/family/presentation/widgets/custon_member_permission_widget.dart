import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_switch/custom_switch_button.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/family/presentation/utils/members_utils.dart';
import 'package:flutter/material.dart';

class CustonMemberPermissionWidget extends StatelessWidget {
  final MemberPermissions memberPermissions;
  final Function(bool) onSwitch;
  final bool isOnSwitch;
  final bool isEnabled;
  const CustonMemberPermissionWidget(
      {Key? key,
      required this.memberPermissions,
      required this.onSwitch,
      required this.isOnSwitch,
      required this.isEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.pW1),
      height: AppSizes.pH9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(memberPermissions.name,
              textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: ThemeColorLight.pinkColor, fontSize: AppSizes.h6)),
          CustomSwitch(
            value: isOnSwitch,
            onChanged: (v) {
              if (isEnabled) {
                onSwitch.call(v);
              }
            },
            isEnabled: isEnabled,
          ),
        ],
      ),
    );
  }
}
