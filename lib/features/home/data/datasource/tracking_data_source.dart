import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/network/api_caller.dart';
import 'package:family_guard/core/network/api_endpoint.dart';
import 'package:family_guard/core/network/model/error_message.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/features/authentication/data/models/user_model.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

abstract class BaseTrackingDataSource {
  Future<String> addNewUserLocation(TrackingParams params);
  Future<List<UserEntity>> trackMyMembers(String accessToken);
}

class TrackingDataSource implements BaseTrackingDataSource {
  @override
  Future<String> addNewUserLocation(TrackingParams params) async {
    
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.addnewUserLocationPath,
      (data) => data,
      token: params.accessToken,
      body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'location': params.trackingEntity.toMap()
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
  Future<List<UserEntity>> trackMyMembers(String accessToken) async{
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.trackMyMembersPath,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      token: accessToken,

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
