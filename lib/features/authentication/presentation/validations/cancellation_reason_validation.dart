import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';

class Validators {
  Validators._();

  static final Validators instance = Validators._();

  String? validationCancelReason(String value) {
    if (value.isEmpty) {
      return tr(AppConstants.cancellationError);
    } else if (value.isNotEmpty) {
      return null;
    }
    return null;
  }
}

bool checkPattern({pattern, value}) {
  RegExp regularCheck = RegExp(pattern);
  if (regularCheck.hasMatch(value)) {
    return true;
  }
  return false;
}
