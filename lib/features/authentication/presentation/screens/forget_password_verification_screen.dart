import 'package:flutter/material.dart';
import 'package:family_guard/features/authentication/presentation/components/authentication_common_body.dart';
import 'package:family_guard/features/authentication/presentation/components/verification_forget_password_content_card_component.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/forget_password_verification_entity.dart';
import '../controller/forget_password_verification_provider.dart';

class ForgetPasswordVerificationScreen extends StatelessWidget {
  final ForgetPasswordVerificationEntity forgetPasswordVerificationEntity;

  const ForgetPasswordVerificationScreen({
    Key? key,
    required this.forgetPasswordVerificationEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgetPasswordVerificationProvider(
          forgetPasswordVerificationEntity: forgetPasswordVerificationEntity),
      child: Consumer<ForgetPasswordVerificationProvider>(
        builder: (context, provider, child) {
          return AuthenticationCommonBody(
              title: tr(AppConstants.verification),
              body: const VerificationForgetPasswordContentCardComponent());
        },
      ),
    );
  }
}
