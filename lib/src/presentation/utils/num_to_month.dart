import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';

String numToMonth(int month) {
  switch (month) {
    case 1:
      return LocaleKeys.january.tr();
    case 2:
      return LocaleKeys.february.tr();
    case 3:
      return LocaleKeys.march.tr();
    case 4:
      return LocaleKeys.april.tr();
    case 5:
      return LocaleKeys.may.tr();
    case 6:
      return LocaleKeys.june.tr();
    case 7:
      return LocaleKeys.july.tr();
    case 8:
      return LocaleKeys.august.tr();
    case 9:
      return LocaleKeys.september.tr();
    case 10:
      return LocaleKeys.october.tr();
    case 11:
      return LocaleKeys.november.tr();
    case 12:
      return LocaleKeys.december.tr();
  }
  return '';
}
