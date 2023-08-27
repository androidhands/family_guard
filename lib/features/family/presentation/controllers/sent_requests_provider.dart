import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/domain/usecases/get_sent_connections_requests_usecase.dart';
import 'package:family_guard/features/family/presentation/screens/add_family_member_screen.dart';
import 'package:family_guard/features/family/presentation/utils/members_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SentRequestsProvider extends ChangeNotifier {
  SentRequestsProvider() {
    getSentRequest();
  }
  UserEntity user =
      Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;

  bool isLoodingRequests = true;
  List<UserEntity>? sentRequest;
  RequestType requestType = RequestType.Sent;

  void getSentRequest() async {
    Either<Failure, List<UserEntity>> results =
        await sl<GetSentConnectionsRequestsUsecase>()(user.apiToken!);
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      sentRequest = r;
    });
    isLoodingRequests = false;
    notifyListeners();
  }

  navigateToAddNewMemberRequest() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.pushReplacement,
        page: () => const AddFamilyMemberScreen());
  }
}
