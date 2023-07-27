import 'package:family_guard/features/authentication/presentation/controller/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../components/authentication_common_body.dart';

class UserAddressSignUpScreen extends StatelessWidget {
  const UserAddressSignUpScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpProvider>(
        create: (context) => SignUpProvider(),
        builder: (context, child) {
          return Consumer<SignUpProvider>(
            builder: (context, provider, child) {
              return AuthenticationCommonBody(
                isScrolling: true,
                title: tr(AppConstants.signUp),
                onLanguageChange: () => provider.validateForm(),
                body: Center(
                  child: Text(provider.firstNameController.text),
                ),
              );
            },
          );
        });
  }
}
