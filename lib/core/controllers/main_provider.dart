import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/domain/usecases/get_cached_user_credentials_usecase.dart';
import '../services/dependency_injection_service.dart';

class MainProvider extends ChangeNotifier {
  MainProvider() {
    initializeApp();
  }

  initializeApp() {
    getUserCredentialsCached();
  }

  getUserCredentialsCached() {}
  late UserEntity? userCredentials;
  Future<UserEntity?> getCachedUserCredentials() async {
    Either<Failure, UserEntity?> results =
        await sl<GetCachedUserCredentialsUsecase>()();
    results.fold((l) {
      log('No cached user');
    }, (r) {
      userCredentials = r;
      return userCredentials;
    });
    return null;
  }
}
