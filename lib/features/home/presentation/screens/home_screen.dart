import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/authentication/presentation/controller/login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widget/buttons/custom_elevated_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      builder: (context, child) {
        return Consumer<LoginProvider>(
          builder: (context, value, child) {
            return Scaffold(
              appBar: const CustomAppbar(),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      tr(AppConstants.welcome),
                      textStyle: Theme.of(context).textTheme.displayLarge!,
                    ),
                    CustomText(
                      Provider.of<MainProvider>(context, listen: false)
                          .userCredentials!
                          .mobile,
                      textStyle: Theme.of(context).textTheme.displayLarge!,
                    ),
                    CustomElevatedButton(
                      text: tr(AppConstants.logOut),
                      onPressed: () async {
                        await Provider.of<MainProvider>(context, listen: false)
                            .logoutUser();
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
