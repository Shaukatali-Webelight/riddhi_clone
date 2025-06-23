import 'package:intl/intl.dart';

class AppDateFormats {
  AppDateFormats._();

  static const String ddMMyy = 'dd/MM/yy';
  static const String month = 'MMMM';
  static const String year = 'y';

  static const String ddMMyyHHmm = 'd/M/yyyy, HH:mm';
  static const String ddMMyyyy = 'dd/MM/yyyy';
  static const String ddmmyyyy = 'dd - MM - yyyy';
  static const String ddMMMyyyy = 'dd MMM yyyy';
  static const String MMMyyyy = 'MMM yyyy';

  static const String hmma = 'h:mm a';
  static const String monthYear = 'MMMM yyyy';
  static const String ddMMMMyyyy = 'dd MMMM yyyy';
  static const String EEEEddMMMMyyyy = 'EEEE, dd MMMM yyyy';

  static String formatDate(DateTime date, String format) {
    return DateFormat(format).format(date);
  }

  static String apiFormattedDate(String date) {
    final parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  static String customerApiDate(String date) {
    // Remove everything after space, e.g., " at 5"
    final cleanedDate = date.split(' ').first; // "2024-08-06"

    // Parse the date with format matching the cleaned input
    final parsedDate = DateFormat('yyyy-MM-dd').parse(cleanedDate);

    // Return in desired format
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  static String isoDateFormat(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('yyyy/MM/dd').format(parsedDate);
  }
}
