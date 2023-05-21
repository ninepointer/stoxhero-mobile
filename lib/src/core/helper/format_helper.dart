import 'package:intl/intl.dart';

class FormatHelper {
  static String formatNumbers(dynamic value, {bool isNegative = false}) {
    if (value != null) {
      num number = value is int || value is double
          ? value.abs()
          : isNegative
              ? num.parse(value).abs()
              : num.parse(value);
      final currencyFormat = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹ ',
      );
      String formattedAmount = currencyFormat.format(number);
      return formattedAmount;
    } else {
      return '-';
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

  static String formatDateTime(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('dd/MM/yyyy hh:mm:ss').format(dateTime);
      return formattedString;
    } else {
      return '-';
    }
  }
}
