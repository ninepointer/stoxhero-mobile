import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormatHelper {
  static String formatNumbers(
    dynamic value, {
    bool isNegative = false,
    bool showSymbol = true,
    bool showDecimal = true,
    int decimal = 2,
  }) {
    if (value == null || value == "null" || value.toString().isEmpty)
      return '₹0';
    if (value != null) {
      num number = value is int || value is double
          ? isNegative
              ? value.abs()
              : value
          : isNegative
              ? num.parse(value ?? '').abs()
              : num.parse(value ?? '');
      final currencyFormat = NumberFormat.currency(
        locale: 'en_IN',
        symbol: showSymbol ? '₹' : '',
        decimalDigits: decimal,
      );

      String formattedAmount = '₹0';
      if (showDecimal) {
        formattedAmount = currencyFormat.format(number);
      } else {
        formattedAmount =
            currencyFormat.format(number).replaceAll(RegExp(r'\.00$'), '');
      }
      return formattedAmount;
    } else {
      return '₹0';
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

  static String formatDateInMonth(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('dd MMM yyyy').format(dateTime);
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

  static String formatDateByMonthWithTime(String? value) {
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

      final monthFormatter = DateFormat('MMM yy hh:mm a');
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
      String formattedString =
          DateFormat('d MMMM yyyy hh:mm a').format(dateTime);
      return formattedString;
    } else {
      return '-';
    }
  }

  static String formatDateTimeToIST(String? value) {
    if (value != null) {
      DateTime dateTimeUTC = DateTime.parse(value);
      DateTime dateTimeIST = dateTimeUTC.add(Duration(hours: 5, minutes: 30));
      String formattedIST = DateFormat('d MMM yy hh:mm a').format(dateTimeIST);
      return formattedIST;
    } else {
      return '-';
    }
  }

  static String formatDateTimeWithoutYearToIST(String? value) {
    if (value != null) {
      DateTime dateTimeUTC = DateTime.parse(value);
      DateTime dateTimeIST = dateTimeUTC.add(Duration(hours: 5, minutes: 30));
      String formattedIST = DateFormat('d MMM HH:mm').format(dateTimeIST);
      return formattedIST;
    } else {
      return '-';
    }
  }

  static String formatDateYear(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('d MMMM yyyy').format(dateTime);
      return formattedString;
    } else {
      return '-';
    }
  }

  // static String formatDateTimeToIST(String? value) {
  //   if (value != null) {
  //     DateTime dateTimeUTC = DateTime.parse(value);
  //     DateTime dateTimeIST = dateTimeUTC.add(Duration(hours: 5, minutes: 30));
  //     String formattedIST = DateFormat('d MMM yy hh:mm a').format(dateTimeIST);
  //     return formattedIST;
  //   } else {
  //     return '-';
  //   }
  // }

  static String formatDateOfBirthToIST(String? value) {
    if (value != null) {
      DateTime dateTimeUTC = DateTime.parse(value);
      DateTime dateTimeIST = dateTimeUTC.add(Duration(hours: 5, minutes: 30));
      String formattedIST = DateFormat('dd-MM-yyyy').format(dateTimeIST);
      return formattedIST;
    } else {
      return '-';
    }
  }

  static String formatDateTimeOnlyToIST(String? value) {
    if (value != null) {
      DateTime dateTimeUTC = DateTime.parse(value);
      DateTime dateTimeIST = dateTimeUTC.add(Duration(hours: 5, minutes: 30));
      String formattedIST = DateFormat('d MMM hh:mm a').format(dateTimeIST);
      return formattedIST;
    } else {
      return '-';
    }
  }

  static String formatDateMonth(String? value) {
    if (value != null) {
      DateTime dateTime = DateTime.parse(value);
      String formattedString = DateFormat('d MMM').format(dateTime);
      return formattedString;
    } else {
      return '-';
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
