import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../../core/component/custom_drop_down_button.dart';
import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/global/theme/theme_color/theme_color_light.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/buttons/custom_elevated_button.dart';
import '../../../../core/widget/custom_appbar.dart';
import '../../../../core/widget/custom_loading_indicator.dart';
import '../../../../core/widget/custom_text.dart';
import '../controllers/add_new_member_provider.dart';

class AddFamilyMemberScreen extends StatelessWidget {
  const AddFamilyMemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddNewMemberController(),
        builder: (context, child) {
          return Consumer<AddNewMemberController>(
              builder: (context, provider, child) {
            return Scaffold(
              appBar: CustomAppbar(
                title: tr(AppConstants.addMember),
                withTransparent: false,
                withOutElevation: true,
                withMenu: true,
                actions: const [SizedBox()],
                popOnPressed: () {
                  NavigationService.goBack();
                },
                popIconsColor: ThemeColorLight.pinkColor,
              ),
              body: Form(
                key: provider.globalKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppSizes.pH2,
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSizes.pH5),
                        child: Card(
                          elevation: 7,
                          margin: EdgeInsets.zero,
                          shadowColor: Colors.black26,
                          color: Colors.transparent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppSizes.br12)),
                            child: Container(
                              padding: EdgeInsets.all(AppSizes.pH5),
                              width: AppSizes.widthFullScreen,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IntlPhoneField(
                                    decoration: InputDecoration(
                                      labelText: tr(AppConstants.phoneNumber),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                    initialCountryCode: provider.countryCode,
                                    dropdownIcon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: ThemeColorLight.pinkColor,
                                    ),
                                    controller: provider.phoneController,
                                    onChanged: (phone) {
                                      provider.setPhoneNumber(phone);
                                    },
                                  ),
                                  SizedBox(
                                    height: AppSizes.sizedBoxH4,
                                  ),
                                  CustomText(
                                    tr(AppConstants.youAre),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            fontSize: AppSizes.h5,
                                            color: ThemeColorLight.pinkColor),
                                  ),
                                  SizedBox(
                                    height: AppSizes.sizedBoxH4,
                                  ),
                                  CustomDropDownButton(
                                    title: provider.selectedSnderRelation.name
                                        .replaceAll("_", " "),
                                    height: AppSizes.dropDownButtonSize,
                                    onClick: () {
                                      provider
                                          .showSendRelationShipsDropDwonDialog();
                                    },
                                  ),
                                  SizedBox(
                                    height: AppSizes.sizedBoxH4,
                                  ),
                                  CustomText(
                                    tr(AppConstants.thisMemberIs),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            fontSize: AppSizes.h5,
                                            color: ThemeColorLight.pinkColor),
                                  ),
                                  SizedBox(
                                    height: AppSizes.sizedBoxH4,
                                  ),
                                  CustomDropDownButton(
                                    title: provider
                                        .selectedReceiverRelation.name
                                        .replaceAll("_", " "),
                                    height: AppSizes.dropDownButtonSize,
                                    onClick: () {
                                      provider
                                          .showReceiverRelationShipsDropDwonDialog();
                                    },
                                  ),
                                  SizedBox(
                                    height: AppSizes.pH2,
                                  ),
                                  CustomElevatedButton(
                                    onPressed: () => provider.sendRequest(),
                                    isLoading: provider.isSendingRequest,
                                    text: tr(AppConstants.sendRequest),
                                    isEnabled: provider.enableVerifyButton,
                                  ),
                                  SizedBox(
                                    height: AppSizes.pH7,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            );
          });
        });
  }
}
