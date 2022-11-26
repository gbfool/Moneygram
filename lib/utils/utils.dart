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
    return list;
  }

  Transaction getDummyTransaction() {
    Transaction transaction = Transaction(
        accountId: 1,
        categoryId: 2,
        amount: 200,
        time: DateTime.now(),
        type: TransactionType.expense);
    return transaction;
  }
}
