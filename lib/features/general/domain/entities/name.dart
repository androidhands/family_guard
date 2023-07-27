import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/services/dependency_injection_service.dart';


class Name {
  final String en;
  final String? ar;
  final String? fr;

  Name({this.en = '', this.ar = '', this.fr = ''});

  String get localizedName =>
      toMap()[sl<BaseAppLocalizations>().getLanguageCode()];

  factory Name.fromMap(Map<String, dynamic> data) {
    return Name(
      ar: data['ar'],
      en: data['en'] ?? '',
      fr: data['fr'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'ar': ar, 'en': en, 'fr': fr};
  }
}
