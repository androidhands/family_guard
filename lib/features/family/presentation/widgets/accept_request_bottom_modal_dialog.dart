import 'dart:convert';
import 'dart:developer';

import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/buttons/custom_outlined_button.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/presentation/controllers/received_requests_provider.dart';
import 'package:family_guard/features/family/presentation/utils/members_utils.dart';
import 'package:family_guard/features/family/presentation/widgets/custon_member_permission_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptRequestBottomModalDialog extends StatefulWidget {
  final UserEntity userEntity;
  final Function(UserEntity) onAcceptRequest;
  final Function(UserEntity) onCancelRequest;
  
  const AcceptRequestBottomModalDialog(
      {Key? key,
      required this.userEntity,
      required this.onAcceptRequest,
      required this.onCancelRequest,
      })
      : super(key: key);

  @override
  State<AcceptRequestBottomModalDialog> createState() =>
      _AcceptRequestBottomModalDialogState();
}

class _AcceptRequestBottomModalDialogState
    extends State<AcceptRequestBottomModalDialog> {
  @override
  Widget build(BuildContext context) {
   
    return Consumer<ReceivedRequestsProvider>(
      builder: (context,provider,child) {
        return Container(
          height: widget.userEntity.memberEntity!.userRelation == "Friend"
              ? AppSizes.memberRequestBottomSheetModalHeight
              : AppSizes.paymentHistoryBottomSheetModalHeight,
          decoration: BoxDecoration(color: Theme.of(context).dialogBackgroundColor),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.pW7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText('Member Connection Request',
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ThemeColorLight.pinkColor, fontSize: AppSizes.h5)),
                SizedBox(
                  height: AppSizes.pH4,
                ),
                CustomText('From ${widget.userEntity.userFullName}',
                    textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ThemeColorLight.pinkColor,
                        fontSize: AppSizes.h6,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: AppSizes.pH2,
                ),
                CustomText(
                    'Adding you as his ${widget.userEntity.memberEntity!.memberRelation}',
                    textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ThemeColorLight.pinkColor,
                        fontSize: AppSizes.h6,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: AppSizes.pH2,
                ),
                CustomText(
                  'These permissions allows you and your member to track each other and make emergency calls to each other, if the relationshipt is not a Friend relation, all permission will be gtanted by default',
                  textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ThemeColorLight.pinkColor,
                        fontSize: AppSizes.h8,
                      ),
                  textAlign: TextAlign.start,
                ),
                if (widget.userEntity.memberEntity!.userRelation == "Friend")
                  CustonMemberPermissionWidget(
                    memberPermissions: MemberPermissions.Emergency,
                    isOnSwitch: widget.userEntity.memberEntity!.emergency == 1,
                    onSwitch: (v) {
                      widget.userEntity.memberEntity!.setEmergency = v ? 1 : 0;
                      setState(() {});
                    },
                    isEnabled:
                        widget.userEntity.memberEntity!.userRelation == "Friend",
                  ),
                if (widget.userEntity.memberEntity!.userRelation == "Friend")
                  CustonMemberPermissionWidget(
                    memberPermissions: MemberPermissions.Tracking,
                    isOnSwitch: widget.userEntity.memberEntity!.tracked == 1,
                    onSwitch: (v) {
                      widget.userEntity.memberEntity!.setTracking = v ? 1 : 0;
                      setState(() {});
                    },
                    isEnabled:
                        widget.userEntity.memberEntity!.userRelation == "Friend",
                  ),
                SizedBox(
                  height: AppSizes.pH2,
                ),
                if (widget.userEntity.memberEntity!.accepted != 1)
                  CustomElevatedButton(
                    onPressed: () {
                      widget.onAcceptRequest.call(widget.userEntity);
                    },
                    text: 'Accept Request',
                    isLoading: provider.isLoadingAcceptAction,
                  ),
                CustomOutlinedButton(
                  onPressed: () {
                    widget.onCancelRequest.call(widget.userEntity);
                  },
                  text: 'Cancel Request',
                  isLoading: provider.isLoadingCancelAction,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
