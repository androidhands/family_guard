import 'package:family_guard/core/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/sign_up_params.dart';
import '../components/authentication_common_body.dart';
import '../components/verification_content_card_component.dart';
import '../controller/verification_provider.dart';

class VerificationScreen extends StatelessWidget {
  final SignUpParams signUpParams;

  const VerificationScreen({Key? key, required this.signUpParams})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VerificationProvider(
        signUpParams: signUpParams,
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
                  backOnPress: () => NavigationService.goBack(),
                  body: VerificationContentCardComponent(
                    signUpParams: signUpParams,
                  ));
        },
      ),
    );
  }
}
