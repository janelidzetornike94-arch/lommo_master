import 'package:intl/intl.dart';

class DateFormatter {
  static String nowReadable() {
    return DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
  }
}
