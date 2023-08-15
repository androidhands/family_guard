import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/usecases/get_family_connections_usecase.dart';

class FamilyMembersProvider extends ChangeNotifier {
  FamilyMembersProvider() {
    getFamilyMembers();
  }
  UserEntity user =
      Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;

  bool isLoadingFamilyMembers = false;
  List<UserEntity> familyMembersList = [];

  void getFamilyMembers() async {
    isLoadingFamilyMembers = true;
    Either<Failure, List<UserEntity>> results =
        await sl<GetFamilyConnectionsUsecase>()();
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      familyMembersList = r;
    });
    isLoadingFamilyMembers = false;
    notifyListeners();
  }
}
