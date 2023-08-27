import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/domain/entities/request_connection_params.dart';
import 'package:family_guard/features/family/domain/usecases/accept_member_connection_usecase.dart';
import 'package:family_guard/features/family/domain/usecases/cancel_member_connection_usecase.dart';
import 'package:family_guard/features/family/domain/usecases/get_received_connection_requests_usecase.dart';
import 'package:family_guard/features/family/presentation/controllers/family_members_provider.dart';
import 'package:family_guard/features/family/presentation/screens/add_family_member_screen.dart';
import 'package:family_guard/features/family/presentation/utils/members_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReceivedRequestsProvider extends ChangeNotifier {
  bool isLoadingAcceptAction = false;
  bool isLoadingCancelAction = false;

  ReceivedRequestsProvider() {
    getReceivedRequest();
  }

  UserEntity user =
      Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;

  bool isLoodingRequests = true;
  List<UserEntity>? receivedRequest;
  RequestType requestType = RequestType.Received;

  void getReceivedRequest() async {
    Either<Failure, List<UserEntity>> results =
        await sl<GetReceivedConnectionRequestsUsecase>()(user.apiToken!);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      receivedRequest = r;
    });
    isLoodingRequests = false;
    notifyListeners();
  }

  navigateToAddNewMemberRequest() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.pushReplacement,
        page: () => const AddFamilyMemberScreen());
  }

  void acceptConnectionRequest(UserEntity userEntity) async {
    isLoadingAcceptAction = true;
    Either<Failure, List<UserEntity>> results =
        await sl<AcceptMemberConnectionUsecase>()(RequestConnectionParams(
            memberEntity: userEntity.memberEntity!,
            accessToken: user.apiToken!));
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) async {
      receivedRequest = r;
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: 'The request accepted',
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
            NavigationService.goBack();
            Provider.of<FamilyMembersProvider>(Get.context!, listen: false).getFamilyMembers();
          });
    });
    isLoadingAcceptAction = false;
    notifyListeners();
  }

  void cancelConnectionRequest(UserEntity userEntity) async {
    isLoadingCancelAction = true;
    Either<Failure, List<UserEntity>> results =
        await sl<CancelMemberConnectionUsecase>()(RequestConnectionParams(
            memberEntity: userEntity.memberEntity!,
            accessToken: user.apiToken!));
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) async {
      receivedRequest = r;
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: 'The request canceled',
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.goBack();
            NavigationService.goBack();
            Provider.of<FamilyMembersProvider>(Get.context!, listen: false).getFamilyMembers();
          });
    });
    isLoadingCancelAction = false;
    notifyListeners();
  }
}
