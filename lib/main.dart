import 'dart:developer';
import 'dart:io';

import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/screen/main_screen.dart';
import 'package:family_guard/core/services/background_location_service.dart';
import 'package:family_guard/features/family/presentation/controllers/family_members_provider.dart';
import 'package:family_guard/features/family/presentation/controllers/received_requests_provider.dart';
import 'package:family_guard/features/family/presentation/screens/received_requests_screen.dart';
import 'package:family_guard/features/family/presentation/screens/sent_requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'core/global/localization/language_translation.dart';
import 'core/global/theme/app_theme.dart';
import 'core/global/theme/controller/theme_provider.dart';
import 'core/global/theme/theme_color/theme_color_dark.dart';
import 'core/global/theme/theme_color/theme_color_light.dart';
import 'core/services/dependency_injection_service.dart';
import 'core/services/service_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await ServiceInitializer().initializeSettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log(Platform.operatingSystem);
    return GestureDetector(
      onTap: () {
        ///TO Handle keyboard Focus
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: false,
        builder: (_, __) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<MainProvider>(
                create: (context) => sl(),
              ),
              ChangeNotifierProvider<ThemeProvider>(
                  create: (context) => ThemeProvider(
                      appTheme: ServiceInitializer.savedAppTheme,
                      themeData:
                          appThemeData[ServiceInitializer.savedAppTheme]!)),
              ChangeNotifierProvider(
                  create: (context) => FamilyMembersProvider()),
              ChangeNotifierProvider(
                  create: (context) => ReceivedRequestsProvider())
            ],
            child: Consumer<ThemeProvider>(
              builder: (BuildContext context, provider, _) {
                ///status color
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarColor: provider.appTheme.index == AppTheme.dark.index
                      ? ThemeColorDark.backgroundColor
                      : ThemeColorLight.backgroundColor, // status bar color
                ));

                return GetMaterialApp(
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  getPages: [
                    GetPage(
                        name: '/SentRequestsScreen',
                        page: () => const SentRequestsScreen()),
                    GetPage(
                        name: '/ReceivedRequestsScreen',
                        page: () => const ReceivedRequestsScreen()),
                  ],
                  supportedLocales: const [Locale('en'), Locale('ar')],
                  fallbackLocale: ServiceInitializer.locale,
                  title: 'Go-Care',
                  debugShowCheckedModeBanner: false,
                  locale: ServiceInitializer.locale,
                  translations: LanguageTranslation(),
                  theme: provider.themeData,
                  home: AnnotatedRegion<SystemUiOverlayStyle>(

                      ///status icon color
                      value: provider.appTheme.index == AppTheme.dark.index
                          ? SystemUiOverlayStyle.light
                          : SystemUiOverlayStyle.dark,
                      child:
                          const MainScreen() /* ResetPasswordScreen(
                        phone: "+201115583344",
                      ) */
                      ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
