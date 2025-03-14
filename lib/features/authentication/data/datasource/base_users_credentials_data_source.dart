import 'dart:convert';
import 'dart:developer';

import 'package:family_guard/features/authentication/data/models/user_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/local_data/shared_preferences_services.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/user_entity.dart';

abstract class BaseUsersCredentialsDataSource {
  Future<bool> saveUserCredentials(UserEntity userEntity);
  Future<UserEntity?> getCachedUserCredentials();
  bool checkUserCredentials();
}

class UsersCredentialsDataSource implements BaseUsersCredentialsDataSource {
  @override
  Future<UserEntity?> getCachedUserCredentials() async {
    try {
      var cachedData = await sl<SharedPreferencesServices>().getData(
        key: AppConstants.authCredential,
        dataType: DataType.string,
      );
      if (cachedData == null) return null;
      Map<String, dynamic> data = json.decode(cachedData);
      return UserModel.fromJson(data);
    } on FormatException catch (ex) {
      throw CacheException(
          message: 'Error caching... ${ex.toString()}', code: 0);
    } catch (ex) {
      throw CacheException(
          message: 'Error caching... ${ex.toString()}', code: 0);
    }
  }

  @override
  Future<bool> saveUserCredentials(UserEntity userEntity) async {
    try {
      log('saving credentials ${userEntity.mobile}');
      await sl<SharedPreferencesServices>().saveData(
        key: AppConstants.authCredential,
        value: jsonEncode(userEntity),
        dataType: DataType.string,
      );
      return true;
    } catch (ex) {
      throw CacheException(
          message: 'Error caching... ${ex.toString()}', code: 0);
    }
  }

  @override
  bool checkUserCredentials() {
    return sl<SharedPreferencesServices>().checkByKey(
      key: AppConstants.authCredential,
    );
  }
}
