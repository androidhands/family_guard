import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/domain/usecases/send_new_member_request_usecase.dart';
import 'package:family_guard/features/family/presentation/screens/sent_requests_screen.dart';
import 'package:family_guard/features/family/presentation/utils/members_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../../authentication/presentation/utils/utils.dart';

class AddNewMemberController extends ChangeNotifier {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  AddNewMemberController() {
    getCountryCode();
    selectedReceiverRelation = getReciverRelations()[selectedSnderRelation]![0];
  }
  String? countryCode;
  bool isloadingCountryCode = true;
  final TextEditingController phoneController = TextEditingController();
  bool enableVerifyButton = false;
  PhoneNumber? phoneNumber;
  Relationships selectedSnderRelation = Relationships.Select_Relation;
  Relationships selectedReceiverRelation = Relationships.Select_Relation;

  bool isSendingRequest = false;

  void setSelectedSenderRelation(Relationships r) {
    selectedSnderRelation = r;
    selectedReceiverRelation = getReciverRelations()[r]![0];
    checkFormReadiness();
    notifyListeners();
  }

  void setSelectedReceiverRelation(Relationships r) {
    selectedReceiverRelation = r;
    checkFormReadiness();
    notifyListeners();
  }

  void checkFormReadiness() {
    bool isNotValid = phoneController.text.isEmpty ||
        !isValidNumber(phoneNumber!) ||
        selectedSnderRelation.name.replaceAll("_", " ") ==
            Relationships.Select_Relation.name.replaceAll("_", " ") ||
        selectedReceiverRelation.name.replaceAll("_", " ") ==
            Relationships.Select_Relation.name.replaceAll("_", " ");
    if (enableVerifyButton != !isNotValid) {
      enableVerifyButton = !isNotValid;
      notifyListeners();
    }
  }

  void setPhoneNumber(PhoneNumber phone) {
    phoneNumber = phone;
    log(isValidNumber(phoneNumber!).toString());
    checkFormReadiness();
  }

  Future getCountryCode() async {
    try {
      countryCode = await FlutterSimCountryCode.simCountryCode;
      log(countryCode!);
    } on PlatformException {
      log('Failed to get sim country code.');
    }
    isloadingCountryCode = false;
    notifyListeners();
  }

  void showReceiverRelationShipsDropDwonDialog() {
    showCustromReceiverDropDwonDialog(
        (s) => setSelectedReceiverRelation(s),
        selectedReceiverRelation.name.replaceAll("_", " "),
        selectedSnderRelation);
  }

  void showSendRelationShipsDropDwonDialog() {
    showCustromDropDwonDialog((s) => setSelectedSenderRelation(s),
        selectedSnderRelation.name.replaceAll("_", " "));
  }

  sendRequest() async {
    isSendingRequest = true;
    Either<Failure, String> results = await sl<SendNewMemberRequestUsecase>()(
        AddNewMemberParams(
            mobile: phoneNumber!.completeNumber,
            sender: selectedSnderRelation.name,
            member: selectedReceiverRelation.name));
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: r,
          buttonText: tr(AppConstants.ok),
          onPressed: () {
            NavigationService.navigateTo(
                navigationMethod: NavigationMethod.pushReplacement,
                page: () => const SentRequestsScreen());
          });
    });
    isSendingRequest = false;
    notifyListeners();
  }
}
