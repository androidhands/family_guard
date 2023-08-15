import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../authentication/data/models/user_model.dart';

abstract class BaseFamilyConnectionsDataSource {
  Future<List<UserEntity>> getFamilyConnections();
}

class FamilyConnectionsDataSource implements BaseFamilyConnectionsDataSource {
  @override
  Future<List<UserEntity>> getFamilyConnections() async {
    UserEntity user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getFamilyConnectionsPath,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      token: user.apiToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }
}
