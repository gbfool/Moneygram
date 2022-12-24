import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';

class Utils {
  static List<Category> getExpensesCategory() {
    List<Category> list = [];
    list.add(Category(emoji: "💧", name: "Water"));
    list.add(Category(emoji: "🥘", name: "Food"));
    list.add(Category(emoji: "🛍️", name: "Shopping"));
    list.add(Category(emoji: "💳", name: "Credit"));
    list.add(Category(emoji: "🛒", name: "Goods"));
    list.add(Category(emoji: "🎮", name: "Games"));
    list.add(Category(emoji: "👕", name: "Clothing"));
    list.add(Category(emoji: "⚡", name: "Elecricity"));
    list.add(Category(emoji: "🎁", name: "Gifts"));
    list.add(Category(emoji: "🍿", name: "Entertainment"));
    list.add(Category(emoji: "📚", name: "Books"));
    list.add(Category(emoji: "🤷", name: "Miscellenous"));
    list.add(Category(emoji: "⚡", name: "Elecricity"));
    list.add(Category(emoji: "🎁", name: "Gifts"));
    list.add(Category(emoji: "🍿", name: "Entertainment"));
    list.add(Category(emoji: "📚", name: "Books"));
    list.add(Category(emoji: "🤷", name: "Miscellenous"));
    list.add(Category(
        emoji: "💼", name: "Income", transactionType: TransactionType.income));
    list.add(Category(
        emoji: "🤑",
        name: "Side Income",
        transactionType: TransactionType.income));
    return list;
  }

  static List<Account> getAccounts() {
    List<Account> list = [];
    list.add(Account(emoji: "💳", name: "Credit Card"));
    list.add(Account(emoji: "💵", name: "Cash"));
    list.add(Account(emoji: "💰", name: "Paytm"));
    return list;
  }

  static Transaction getDummyTransaction() {
    Transaction transaction = Transaction(
        accountId: 1,
        categoryId: 0,
        notes: "Hello Himanshu",
        amount: 200,
        time: DateTime.now(),
        type: TransactionType.expense);
    return transaction;
  }

  static String getRemovedZeroFromDecimal(double price) {
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    return price.toString().replaceAll(regex, "");
  }
}
