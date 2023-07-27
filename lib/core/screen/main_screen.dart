import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/images/custom_png_image.dart';

import '../services/dependency_injection_service.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (context) => sl(),
      builder: (context, child) {
        return Consumer<MainProvider>(
          builder: (context, value, child) {
            return Scaffold(
              
              body: Center(
                child: CustomPngImage(
                  path: AppAssets.logoBluePng,
                  width: AppSizes.logoImageWidth,
                  height: AppSizes.registrationPhotoHeight,
                  radius: BorderRadius.zero,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
