import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/feature_flags/feature_flag_helper.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';

class Utils {
  static String currentAppVersion = "1.0.0";
  static List<Category> getExpensesCategory() {
    List<Category> list = [];
    list.add(Category(emoji: "💧", name: "Water", isCustomCategory: false));
    list.add(Category(emoji: "🥘", name: "Food", isCustomCategory: false));
    list.add(Category(emoji: "🛍️", name: "Shopping", isCustomCategory: false));
    list.add(Category(emoji: "🛒", name: "Goods", isCustomCategory: false));
    list.add(Category(emoji: "🎮", name: "Games", isCustomCategory: false));
    list.add(Category(emoji: "👕", name: "Clothing", isCustomCategory: false));
    list.add(Category(emoji: "💪", name: "Fitness", isCustomCategory: false));
    list.add(Category(emoji: "⚡", name: "Elecricity", isCustomCategory: false));
    list.add(Category(emoji: "🎁", name: "Gifts", isCustomCategory: false));
    list.add(
        Category(emoji: "🍿", name: "Entertainment", isCustomCategory: false));
    list.add(Category(emoji: "📚", name: "Books", isCustomCategory: false));
    list.add(Category(emoji: "🍪", name: "Snacks", isCustomCategory: false));
    list.add(
        Category(emoji: "🤷", name: "Miscellenous", isCustomCategory: false));
    list.add(Category(
        emoji: "💼",
        name: "Income",
        transactionType: TransactionType.income,
        isCustomCategory: false));
    list.add(Category(
        emoji: "🤑",
        name: "Side Income",
        transactionType: TransactionType.income,
        isCustomCategory: false));
    return list;
  }

  static List<Account> getAccounts() {
    List<Account> list = [];
    list.add(Account(emoji: "💳", name: "Credit Card", isCustomAccount: false));
    list.add(Account(emoji: "💵", name: "Cash", isCustomAccount: false));
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

  static int compareVersions(String str1, String str2) {
    var vals1 = str1.split(".");
    var vals2 = str2.split(".");
    int i = 0;
    // set index to first non-equal ordinal or length of shortest version string
    while (i < vals1.length && i < vals2.length && vals1[i] == (vals2[i])) {
      i++;
    }
    // compare first non-equal ordinal number
    if (i < vals1.length && i < vals2.length) {
      return int.tryParse(vals1[i])! > int.tryParse(vals2[i])! ? 1 : 0;
    }
    // the strings are equal or one string is a substring of the other
    // e.g. "1.2.3" = "1.2.3" or "1.2.3" < "1.2.3.4"
    return vals1.length > vals2.length ? 1 : 0;
  }

  // check if update is available or not
  static bool isUpdateAvailable() {
    String? latestAppVersion = FeatureFlagHelper.instance.getLatestAppVersion();
    print("latestAppVersion $latestAppVersion");
    if (latestAppVersion == null) {
      return false;
    }
    return Utils.compareVersions(latestAppVersion, currentAppVersion) == 1;
  }

  static bool isForceUpdateAvailable() {
    String? minAppVersion = FeatureFlagHelper.instance.getMinAppVersion();
    print("minAppVersion $minAppVersion");
    if (minAppVersion == null) {
      return false;
    }
    return Utils.compareVersions(minAppVersion, currentAppVersion) == 1;
  }
}
