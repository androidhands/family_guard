import 'dart:convert';

import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/features/authentication/data/models/address_model.dart';
import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/local_data/shared_preferences_services.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/utils/app_constants.dart';

abstract class BaseUserAddressDataSource {
  Future<AddressEntity> getUserAddress();
  Future<AddressEntity> saveUserAddress(AddressEntity addressParams);
  Future<bool> cacheSavedUserAddress(AddressEntity addressParams);
  Future<AddressEntity> getCachedUserAddress();
}

class UserAddressDataSource implements BaseUserAddressDataSource {
  @override
  Future<bool> cacheSavedUserAddress(AddressEntity addressParams) async {
    try {
      await sl<SharedPreferencesServices>().saveData(
        key: AppConstants.cachedUserAddress,
        value: jsonEncode(addressParams),
        dataType: DataType.string,
      );
      return true;
    } catch (ex) {
      throw CacheException(
          message: 'Error caching... ${ex.toString()}', code: 0);
    }
  }

  @override
  Future<AddressEntity> getCachedUserAddress() async {
    try {
      var cachedData = await sl<SharedPreferencesServices>().getData(
        key: AppConstants.cachedUserAddress,
        dataType: DataType.string,
      );
 
      Map<String, dynamic> data = json.decode(cachedData);
      return AddressModel.fromJson(data);
    } catch (ex) {
      throw CacheException(
          message: 'Error caching... ${ex.toString()}', code: 0);
    }
  }

  @override
  Future<AddressEntity> getUserAddress() async{
     UserEntity? user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials;
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getUserAddressPath,
      (data) => AddressModel.fromJson(data),
      token: user?.apiToken,
        body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'mobile': user?.mobile
      },
      onFailure: (ErrorMessage failureData) {
        failureData.code == "23000"
            ? throw ServerException(
                message: 'Douplicated Entry',
                code: failureData.code,
              )
            : throw ServerException(
                message: failureData.message,
                code: failureData.code,
              );
      },
    );
  }

  @override
  Future<AddressEntity> saveUserAddress(AddressEntity addressParams) async {
    UserEntity? user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials;
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.addUserAddressPath,
      (data) => AddressModel.fromJson(data),
      body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'address': jsonEncode(addressParams)
      },
      token: user?.apiToken,
      onFailure: (ErrorMessage failureData) {
        failureData.code == "23000"
            ? throw ServerException(
                message: 'Douplicated Entry',
                code: failureData.code,
              )
            : throw ServerException(
                message: failureData.message,
                code: failureData.code,
              );
      },
    );
  }
}
