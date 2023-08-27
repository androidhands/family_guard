import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../global/localization/app_localization.dart';
import 'dependency_injection_service.dart';

class DateParser {
  DateTime getCurrentUTC() {
    return DateTime.now().toUtc();
  }

  String? convertLocalToUTC(DateTime? localDateTime) {
    return localDateTime?.toUtc().toString().replaceFirst(' ', 'T');
  }

  String? convertDateToLocalString(DateTime? localDateTime) {
    return localDateTime?.toString().replaceFirst(' ', 'T');
  }

  String? convertLocalStringToUTC(String localDateTime) {
    DateTime? parsedDate = DateTime.tryParse(localDateTime);
    if (parsedDate == null) {
      throw 'Time is not well-formatted in a local date time format';
    }
    return convertDateToLocalString(parsedDate.toUtc());
  }

  DateTime? convertStringToDate(String localDateTime) {
    DateTime? parsedDate = DateTime.tryParse(localDateTime);
    if (parsedDate == null) {
      throw 'Time is not well-formatted in a local date time format';
    }
    return parsedDate;
  }

  String? convertUTCToLocalTime(DateTime? localDateTime) {
    if (localDateTime == null) return null;
    if (!localDateTime.isUtc) {
      throw 'Time must be in utc format to be transformed to local';
    }
    return dateFormatter(localDateTime.toLocal());
  }

  DateTime? convertUTCStringToLocalTime(String? localDateTime,
      {String format = "yyyy-MM-dd HH:mm:ss"}) {
    if (localDateTime == null) return null;
    var dateTime = DateFormat(format)
        .parse(localDateTime.replaceAll('T', ' ').replaceAll('Z', ' '), true);
    var dateLocal = dateTime.toLocal();
    return dateLocal;
  }

  String dateFormatter(DateTime dateTime,
      {String format = 'yyyy-MM-dd,hh:mm:ss'}) {
    initializeDateFormatting(AppLocalizations().getLanguageCode(), null);
    return DateFormat(format, AppLocalizations().getLanguageCode())
        .format(dateTime);
  }

  String formatUtc(String utc, {String format = 'hh:mm a'}) => sl<DateParser>()
      .dateFormatter(sl<DateParser>().convertUTCStringToLocalTime(utc)!,
          format: format);

  String dateFormatterWithoutTime(dynamic dateTime) {
    if ((dateTime is! String) &&
        (dateTime is! DateTime) &&
        !(dateTime == null)) {
      throw "Only String and DateTime accepted";
    }
    DateTime? parsedDate;
    parsedDate = (dateTime is String) ? DateTime.tryParse(dateTime) : dateTime;
    if (parsedDate == null) throw "Date isn't in a valid format to be parsed";
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  String monthFormatter(dynamic dateTime) {
    if ((dateTime is! String) &&
        (dateTime is! DateTime) &&
        !(dateTime == null)) {
      throw "Only String and DateTime accepted";
    }
    DateTime? parsedDate;
    parsedDate = (dateTime is String) ? DateTime.tryParse(dateTime) : dateTime;
    if (parsedDate == null) throw "Date isn't in a valid format to be parsed";
    return DateFormat('yyyy MMMM').format(parsedDate);
  }

  String yearFormatter(dynamic dateTime) {
    if ((dateTime is! String) &&
        (dateTime is! DateTime) &&
        !(dateTime == null)) {
      throw "Only String and DateTime accepted";
    }
    DateTime? parsedDate;
    parsedDate = (dateTime is String) ? DateTime.tryParse(dateTime) : dateTime;
    if (parsedDate == null) throw "Date isn't in a valid format to be parsed";
    return DateFormat('yyyy').format(parsedDate);
  }

  String dateFormatterOnlyTime(dynamic dateTime) {
    if ((dateTime is! String) &&
        (dateTime is! DateTime) &&
        !(dateTime == null)) {
      throw "Only String and DateTime accepted";
    }
    DateTime? parsedDate;
    parsedDate = (dateTime is String) ? DateTime.tryParse(dateTime) : dateTime;

    if (parsedDate == null) throw "Date isn't in a valid format to be parsed";
    return DateFormat('hh:mm a', sl<BaseAppLocalizations>().getLanguageCode())
        .format(parsedDate.toLocal());
  }

  String dateFormatterOnlyDateTime(dynamic dateTime) {
    if ((dateTime is! String) &&
        (dateTime is! DateTime) &&
        !(dateTime == null)) {
      throw "Only String and DateTime accepted";
    }
    DateTime? parsedDate;
    parsedDate = (dateTime is String) ? DateTime.tryParse(dateTime) : dateTime;
    if (parsedDate == null) throw "Date isn't in a valid format to be parsed";
    return DateFormat(
            'yyyy-MM-dd hh:mm a', sl<BaseAppLocalizations>().getLanguageCode())
        .format(parsedDate);
  }
}
