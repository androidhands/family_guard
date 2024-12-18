import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/main_provider.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/local_data/shared_preferences_services.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../domain/entities/sign_in_params.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

abstract class BaseManualSingInDataSource {
  Future<UserEntity> signInUserManually(SignInParams signInParams);
  Future<bool> signOutUser();
  Future<String> deleteUserAccount(String token);
}

class ManualSingInDataSource implements BaseManualSingInDataSource {
  @override
  Future<UserEntity> signInUserManually(SignInParams signInParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.manualSignInPath,
      (data) => UserModel.fromJson(data),
      body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'mobile': signInParams.mobile,
        'password': signInParams.password,
        'token': signInParams.token,
        'platform': signInParams.platform
      },
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<bool> signOutUser() async {
    try {
      final cacheDir = await getTemporaryDirectory();

      if (cacheDir.existsSync()) {
        if (Platform.isAndroid) {
          cacheDir.deleteSync(recursive: true);
        }
      }

      final appDir = await getApplicationSupportDirectory();

      if (appDir.existsSync()) {
        if (Platform.isAndroid) {
          appDir.deleteSync(recursive: true);
        }
      }
      sl<SharedPreferencesServices>().clearAll();
      await FirebaseAuth.instance.signOut();

      UserEntity? user = Provider.of<MainProvider>(Get.context!, listen: false)
          .userCredentials;
      return await sl<ApiCaller>().requestPost(
        ApiEndPoint.logoutPath,
        (data) => true,
        token: user!.apiToken,
        onFailure: (ErrorMessage failureData) {
          throw ServerException(
            message: failureData.message,
            code: failureData.code,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message!, code: '');
    }
  }

  @override
  Future<String> deleteUserAccount(String token) async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      if (Platform.isAndroid) {
        cacheDir.deleteSync(recursive: true);
      }
    }

    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      if (Platform.isAndroid) {
        appDir.deleteSync(recursive: true);
      }
    }
    sl<SharedPreferencesServices>().clearAll();
    await FirebaseAuth.instance.signOut();

    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.deleteUserAccountPath,
      (data) => data,
      token: token,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }
}
