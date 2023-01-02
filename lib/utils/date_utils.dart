import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MyDateUtils {
  static String formatTaskDate(DateTime dateTime, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    DateFormat formatter = DateFormat('dd/MM/yyyy', locale);
    return formatter.format(dateTime);
  }

  static DateTime extractDateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
