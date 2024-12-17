import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formatDateTime(DateTime dateTime) {
  // Create formatters for date and time
  final DateFormat dateFormatter = DateFormat('M/d/yyyy');
  final DateFormat timeFormatter = DateFormat('h:mm:ss a');

  // Format date and time separately
  String formattedDate = dateFormatter.format(dateTime);
  String formattedTime = timeFormatter.format(dateTime);

  // Combine with newline
  return '$formattedDate,\n$formattedTime';
}

class ArabicNumberConverter {
  static String numberToArabicWords(int number) {
    switch (number) {
      case 0:
        return 'صفر';
      case 1:
        return 'واحد';
      case 2:
        return 'اثنان';
      case 3:
        return 'ثلاثة';
      case 4:
        return 'أربعة';
      case 5:
        return 'خمسة';
      case 6:
        return 'ستة';
      case 7:
        return 'سبعة';
      case 8:
        return 'ثمانية';
      case 9:
        return 'تسعة';
      case 10:
        return 'عشرة';
      default:
        return number.toString(); // Return as is for unsupported numbers
    }
  }
}

class DateTimeFormatter {
  static String getArabicDate(DateTime date) {
    final formatter = DateFormat.yMMMMd('ar');
    return formatter.format(date);
  }

  static String format(DateTime dateTime, {bool includeSeconds = true}) {
    // Create date formatter
    final DateFormat dateFormatter = DateFormat('M/d/yyyy');

    // Create time formatter based on whether seconds are included
    final DateFormat timeFormatter =
        DateFormat(includeSeconds ? 'h:mm:ss a' : 'h:mm a');

    // Format date and time separately
    String formattedDate = dateFormatter.format(dateTime);
    String formattedTime = timeFormatter.format(dateTime);

    // Combine with newline
    return '$formattedDate\n,$formattedTime';
  }

  static String formatForPdf(DateTime dateTime, {bool includeSeconds = true}) {
    // Create date formatter
    final DateFormat dateFormatter = DateFormat('M/d/yyyy');

    // Create time formatter based on whether seconds are included
    final DateFormat timeFormatter =
        DateFormat(includeSeconds ? 'h:mm:ss a' : 'h:mm a');

    // Format date and time separately
    String formattedDate = dateFormatter.format(dateTime);
    String formattedTime = timeFormatter.format(dateTime);

    // Combine with newline
    return '$formattedDate, $formattedTime';
  }

  // Get current datetime in the specified format
  static String getCurrentDateTime({bool includeSeconds = true}) {
    return format(DateTime.now(), includeSeconds: includeSeconds);
  }

  // Format timestamp (milliseconds since epoch)
  static String formatTimestamp(int timestamp, {bool includeSeconds = true}) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format(dateTime, includeSeconds: includeSeconds);
  }
}
