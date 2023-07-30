import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/features/authentication/presentation/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/features/authentication/presentation/components/authentication_common_body.dart';
import 'package:family_guard/features/authentication/presentation/components/verification_forget_password_content_card_component.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';

import '../controller/forget_password_verification_provider.dart';

class ForgetPasswordVerificationScreen extends StatelessWidget {
  final String phone;
  final Channels channels;


  const ForgetPasswordVerificationScreen(
      {Key? key, required this.phone, required this.channels})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ForgetPasswordVerificationProvider(phone: phone, channels: channels),
      child: Consumer<ForgetPasswordVerificationProvider>(
        builder: (context, provider, child) {
          return AuthenticationCommonBody(
              title: tr(AppConstants.verification),
              
              backOnPress: () => NavigationService.goBack(),
              body: const VerificationForgetPasswordContentCardComponent());
        },
      ),
    );
  }
}
