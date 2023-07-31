import 'dart:io';

import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/services/firebase_messaging_services.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';

abstract class BaseFcmTokensDataSource {
 
}

class FcmTokensDataSource implements BaseFcmTokensDataSource {

}
