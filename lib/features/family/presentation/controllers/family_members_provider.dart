import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/presentation/screens/add_family_member_screen.dart';
import 'package:family_guard/features/family/presentation/screens/received_requests_screen.dart';
import 'package:family_guard/features/family/presentation/screens/show_member_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/usecases/get_family_connections_usecase.dart';
import '../screens/sent_requests_screen.dart';

class FamilyMembersProvider extends ChangeNotifier {
  FamilyMembersProvider() {
    getFamilyMembers();
  }
  UserEntity user =
      Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;

  bool isLoadingFamilyMembers = false;

  List<UserEntity> members = [];

  void getFamilyMembers() async {
    isLoadingFamilyMembers = true;
    notifyListeners();
    Either<Failure, Stream<List<UserEntity>>> results =
        await sl<GetFamilyConnectionsUsecase>()(user.apiToken!);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) async {
      r.listen((event) {
        members = event;
      });
    });
    isLoadingFamilyMembers = false;
    notifyListeners();
  }

  void navigateToMemberDetailsScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const ShowMemberScreen());
  }

  void navigateToAddMemberScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const AddFamilyMemberScreen());
  }

  void navigateToReceivedRequestsScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const ReceivedRequestsScreen());
  }

  void navigateToSentRequestsScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const SentRequestsScreen());
  }

}
