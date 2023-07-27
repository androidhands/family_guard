import 'package:flutter/material.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../components/authentication_common_body.dart';
import '../components/verification_content_card_component.dart';
import '../controller/verification_provider.dart';

class VerificationScreen extends StatelessWidget {
  final String emailOrPhone;
  final bool isPhone;

  const VerificationScreen(
      {Key? key, required this.emailOrPhone, required this.isPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VerificationProvider(
        emailOrPhone: emailOrPhone,
        isPhone: isPhone,
      ),
      child: Consumer<VerificationProvider>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? Container(
                  color: Theme.of(context).colorScheme.background,
                  child: CustomLoadingIndicators.loadingAnimation(),
                )
              : AuthenticationCommonBody(
                  title: tr(AppConstants.verification),
                  body: VerificationContentCardComponent(
                    emailOrPhone: emailOrPhone,
                    isPhone: isPhone,
                  ));
        },
      ),
    );
  }
}
