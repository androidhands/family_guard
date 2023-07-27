import 'package:family_guard/core/global/localization/app_localization.dart';

import 'package:family_guard/features/general/domain/entities/name.dart';

import '../../../../core/services/dependency_injection_service.dart';

class NameModel extends Name {
  NameModel({String en = '', String ar = '', String fr = ''})
      : super(ar: ar, en: en, fr: fr);

  factory NameModel.fromMap(Map<String, dynamic> json) => NameModel(
      fr: json['fr'] ?? '', en: json['en'] ?? '', ar: json['ar'] ?? '');

  @override
  String get localizedName =>
      toMap()[sl<BaseAppLocalizations>().getLanguageCode()];

  factory NameModel.fromName(Name name) {
    return NameModel(
      en: name.en,
      ar: name.ar ?? '',
      fr: name.fr ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        "fr": fr,
        "en": en,
        "ar": ar,
      };
}
