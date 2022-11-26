import 'package:intl/intl.dart';
import 'package:moneygram/transactions/models/transaction.dart';

class CurrencyHelper {
  static String getCurrency() {
    var format = NumberFormat.simpleCurrency(locale: 'en_IN');
    return format.currencySymbol;
  }

  static String formattedCurrency(double currency, {int? decimalDigits = 2}) {
    var currentLocale = "INR";
    return NumberFormat.simpleCurrency(
      locale: currentLocale.toString(),
      decimalDigits: decimalDigits,
    ).format(currency);
  }

  static String totalExpenseWithSymbol(List<Transaction> transactions) {
    final total = transactions
        .map((e) => e.amount)
        .fold<double>(0, (previousValue, element) => previousValue + element);
    return formattedCurrency(total);
  }
}
