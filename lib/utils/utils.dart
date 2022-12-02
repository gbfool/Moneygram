import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';

class Utils {
  static List<Category> getExpensesCategory() {
    List<Category> list = [];
    list.add(Category(
        emoji: "💧",
        name: "Water",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🥘",
        name: "Food",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🛍️",
        name: "Shopping",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "💳",
        name: "Credit",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🛒",
        name: "Goods",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🎮",
        name: "Games",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "👕",
        name: "Clothing",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "⚡",
        name: "Elecricity",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🎁",
        name: "Gifts",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🍿",
        name: "Entertainment",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "📚",
        name: "Books",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🤷",
        name: "Miscellenous",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "⚡",
        name: "Elecricity",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🎁",
        name: "Gifts",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🍿",
        name: "Entertainment",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "📚",
        name: "Books",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Category(
        emoji: "🤷",
        name: "Miscellenous",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    return list;
  }

  static List<Account> getAccounts() {
    List<Account> list = [];
    list.add(Account(
        emoji: "💳",
        name: "Credit Card",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Account(
        emoji: "💵",
        name: "Cash",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    list.add(Account(
        emoji: "💰",
        name: "Paytm",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()));
    return list;
  }

  static Transaction getDummyTransaction() {
    Transaction transaction = Transaction(
        accountId: 1,
        categoryId: 0,
        notes: "Hello Himanshu",
        amount: 200,
        time: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        type: TransactionType.expense);
    return transaction;
  }

  static String getRemovedZeroFromDecimal(double price) {
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    return price.toString().replaceAll(regex, "");
  }
}
