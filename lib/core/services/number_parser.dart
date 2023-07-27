import 'package:arabic_numbers/arabic_numbers.dart';
import '../../../../core/global/localization/app_localization.dart';

final ArabicNumbers arabicNumber = ArabicNumbers();

extension NumberParserExtention on dynamic {
  String numberParserToArabic() {
    return AppLocalizations().isEnglish()
        ? toString()
        : arabicNumber.convert(toString());
  }
}
