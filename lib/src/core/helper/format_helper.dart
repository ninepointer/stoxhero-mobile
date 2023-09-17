import 'package:intl/intl.dart';

class FormatHelper {
  static String formatNumbers(
    dynamic value, {
    bool isNegative = false,
    bool showSymbol = true,
    int decimal = 2,
  }) {
    if (value == null || value.toString().isEmpty) return '0';
    if (value != null) {
      num number = value is int || value is double
          ? isNegative
              ? value.abs()
              : value
          : isNegative
              ? num.parse(value).abs()
              : num.parse(value);
      final currencyFormat = NumberFormat.currency(
        locale: 'en_IN',
        symbol: showSymbol ? '₹ ' : '',
        decimalDigits: decimal,
      );

      String formattedAmount = currencyFormat.format(number);
      return formattedAmount;
    } else {
      return '0';
    }
  }

  static String formatDate(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedString;
    } else {
      return '-';
    }
  }

  static String formatDateByMonth(String? value) {
    if (value != null) {
      final parsedDate = DateTime.parse(value);
      final dayFormatter = DateFormat('d');
      final day = dayFormatter.format(parsedDate);

      String dayWithSuffix;
      if (day.endsWith('1') && day != '11')
        dayWithSuffix = '${day}st';
      else if (day.endsWith('2') && day != '12')
        dayWithSuffix = '${day}nd';
      else if (day.endsWith('3') && day != '13')
        dayWithSuffix = '${day}rd';
      else
        dayWithSuffix = '${day}th';

      final monthFormatter = DateFormat('MMMM');
      final month = monthFormatter.format(parsedDate);

      final formattedString = '$dayWithSuffix $month';
      return formattedString;
    } else {
      return '-';
    }
  }

  static String formatDateTime(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('d MMMM yyyy hh:mm a').format(dateTime);
      return formattedString;
    } else {
      return '-';
    }
  }

  static String formatDateTimeToIST(String? value) {
    if (value != null) {
      DateTime dateTimeUTC = DateTime.parse(value);
      DateTime dateTimeIST = dateTimeUTC.add(Duration(hours: 5, minutes: 30));
      String formattedIST = DateFormat('d MMM yyyy hh:mm a').format(dateTimeIST);
      return formattedIST;
    } else {
      return '-';
    }
  }
}
