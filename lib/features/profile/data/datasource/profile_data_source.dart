import 'dart:io';

import 'package:dio/dio.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../domain/usecases/save_profile_image_usecase.dart';
import 'package:http_parser/http_parser.dart';

abstract class BaseProfileDataSource {
  Future<UserEntity> saveUserProfileImage(
      SaveProfileImageParams saveProfileImageParams);
}

class ProfileDataSource implements BaseProfileDataSource {
  @override
  Future<UserEntity> saveUserProfileImage(saveProfileImageParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.saveUserProfileImagePath,
      (data) => UserModel.fromJson(data),
      body: <String, dynamic>{
        "api_password": ApiEndPoint.apiPassword,
        "photo": await MultipartFile.fromFile(saveProfileImageParams.image.path,
            filename: saveProfileImageParams.image.name,
            contentType: MediaType('image', 'jpeg')),
      },
      token: saveProfileImageParams.token,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }
}
