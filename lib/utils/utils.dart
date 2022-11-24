import 'package:moneygram/models/category.dart';

class Utils {
  static List<Category> getExpensesCategory() {
    List<Category> list = [];
    list.add(Category(emoji: "💧", text: "Water"));
    list.add(Category(emoji: "🥘", text: "Food"));
    list.add(Category(emoji: "🛍️", text: "Shopping"));
    list.add(Category(emoji: "💳", text: "Credit"));
    list.add(Category(emoji: "🛒", text: "Goods"));
    list.add(Category(emoji: "🎮", text: "Games"));
    list.add(Category(emoji: "👕", text: "Clothing"));
    list.add(Category(emoji: "⚡", text: "Elecricity"));
    list.add(Category(emoji: "🎁", text: "Gifts"));
    list.add(Category(emoji: "🍿", text: "Entertainment"));
    list.add(Category(emoji: "📚", text: "Books"));
    list.add(Category(emoji: "🤷", text: "Miscellenous"));
    return list;
  }
}
