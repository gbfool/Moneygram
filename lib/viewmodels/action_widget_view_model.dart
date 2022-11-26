import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/account/repository/account_repository.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/viewmodels/base_view_model.dart';

class ActionWidgetViewModel extends BaseViewModel {
  ActionWidgetViewModel(
      {required this.accountRepository, required this.categoryRepository});

  final AccountRepository accountRepository;
  final CategoryRepository categoryRepository;

  Category? _category;
  Account? _account;

  void setValues({required int? categoryId, required int? accountId}) async {
    await _setCategory(categoryId: categoryId);
    await _setAccount(accountId: accountId);
    notifyListeners();
  }

  Future<void> _setCategory({required int? categoryId}) async {
    if (categoryId == null) {
      return;
    }
    _category = await categoryRepository.fetchCategoryFromId(categoryId);
  }

  Future<void> _setAccount({required int? accountId}) async {
    if (accountId == null) {
      return;
    }
    _account = await accountRepository.fetchAccountFromId(accountId);
  }

  Category getCategory() {
    if (_category != null) {
      return _category!;
    }
    return Category(emoji: "🫠", name: "Default Category");
  }

  Category getAccount() {
    if (_category != null) {
      return _category!;
    }
    return Category(emoji: "🫠", name: "Default Account");
  }

  // Account getAccount() {
  //   if (account != null) {
  //     return account!;
  //   }
  //   return Account(emoji: "🫠", name: "Default Account");
  // }
}
