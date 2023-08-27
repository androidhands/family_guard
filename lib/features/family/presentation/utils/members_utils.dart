import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/utils.dart';
enum RequestType{Sent,Received}
enum MemberPermissions{Emergency,Tracking}
enum Relationships {
  Select_Relation,
  Fahter,
  Mother,
  Hausband,
  Wife,
  Son,
  Daughter,
  Grandson,
  Granddaughter,
  Brother,
  Sister,
  Grandfather,
  Grandmother,
  Uncle,
  Aunt,
  Nephew,
  Friend
}

Map<Relationships, List<Relationships>> getReciverRelations() {
  return {
    Relationships.Select_Relation: [Relationships.Select_Relation],
    Relationships.Fahter: [
      Relationships.Select_Relation,
      Relationships.Son,
      Relationships.Daughter
    ],
    Relationships.Mother: [
      Relationships.Select_Relation,
      Relationships.Son,
      Relationships.Daughter
    ],
    Relationships.Friend: [Relationships.Select_Relation, Relationships.Friend],
    Relationships.Hausband: [Relationships.Select_Relation, Relationships.Wife],
    Relationships.Wife: [Relationships.Select_Relation, Relationships.Hausband],
    Relationships.Daughter: [
      Relationships.Select_Relation,
      Relationships.Fahter,
      Relationships.Mother
    ],
    Relationships.Son: [
      Relationships.Select_Relation,
      Relationships.Fahter,
      Relationships.Mother
    ],
    Relationships.Sister: [
      Relationships.Select_Relation,
      Relationships.Sister,
      Relationships.Brother
    ],
    Relationships.Brother: [
      Relationships.Select_Relation,
      Relationships.Sister,
      Relationships.Brother
    ],
    Relationships.Granddaughter: [
      Relationships.Select_Relation,
      Relationships.Grandfather,
      Relationships.Grandmother
    ],
    Relationships.Grandson: [
      Relationships.Select_Relation,
      Relationships.Grandfather,
      Relationships.Grandmother
    ],
    Relationships.Grandfather: [
      Relationships.Select_Relation,
      Relationships.Granddaughter,
      Relationships.Grandson
    ],
    Relationships.Grandmother: [
      Relationships.Select_Relation,
      Relationships.Granddaughter,
      Relationships.Grandson
    ],
    Relationships.Uncle: [
      Relationships.Select_Relation,
      Relationships.Nephew,
    ],
    Relationships.Aunt: [
      Relationships.Select_Relation,
      Relationships.Nephew,
    ],
    Relationships.Nephew: [
      Relationships.Select_Relation,
      Relationships.Uncle,
      Relationships.Aunt,
    ],
  };
}

void showCustromDropDwonDialog(
    Function(Relationships) onSelected, String title) {
  Get.defaultDialog(
      title: title, //tr(AppConstants.selectAccountType),
      content: SizedBox(
        height: 300,
        width: 200,
        child: ListView(
            children: List.generate(
                Relationships.values.length,
                (index) => GestureDetector(
                    onTap: () {
                      onSelected(Relationships.values[index]);
                      NavigationService.goBack();
                    },
                    child: CustomTitleCard(
                        title: Relationships.values[index].name
                            .replaceAll("_", " ")))).toList()),
      )
      /*   onCancel: () {
          NavigationService.goBack();
        } */
      );
}

void showCustromReceiverDropDwonDialog(
    Function(Relationships) onSelected, String title, Relationships sender) {
  Get.defaultDialog(
      title: title, //tr(AppConstants.selectAccountType),
      content: SizedBox(
        height: 300,
        width: 200,
        child: ListView(
            children: List.generate(
                getReciverRelations()[sender]!.length,
                (index) => GestureDetector(
                    onTap: () {
                      onSelected(getReciverRelations()[sender]![index]);
                      NavigationService.goBack();
                    },
                    child: CustomTitleCard(
                        title: getReciverRelations()[sender]![index]
                            .name
                            .replaceAll("_", " ")))).toList()),
      )
      /*   onCancel: () {
          NavigationService.goBack();
        } */
      );
}
