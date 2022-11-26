import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/account/repository/account_repository.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/viewmodels/add_transaction_view_model.dart';
import 'package:moneygram/viewmodels/base_view_model.dart';

class ActionWidgetViewModel extends BaseViewModel {
  ActionWidgetViewModel(
      {required this.accountRepository, required this.categoryRepository});

  final AccountRepository accountRepository;
  final CategoryRepository categoryRepository;
  late AddTransactionViewModel _transactionViewModel;

  Category? _category;
  Account? _account;

  void init(
      {required AddTransactionViewModel transactionViewModel}) async {
    _transactionViewModel = transactionViewModel;
    await _setCategory(categoryId: transactionViewModel.selectedCategoryId);
    await _setAccount(accountId: transactionViewModel.selectedAccountId);
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

  Account getAccount() {
    if (_account != null) {
      return _account!;
    }
    return Account(emoji: "🫠", name: "Default Account");
  }

  void setCategory(Category category) {
    _category = category;
    _transactionViewModel.selectedCategoryId = category.id;
    notifyListeners();
  }

  void setAccount(Account account) {
    _account = account;
    _transactionViewModel.selectedAccountId = account.id;
    notifyListeners();
  }

  // Account getAccount() {
  //   if (account != null) {
  //     return account!;
  //   }
  //   return Account(emoji: "🫠", name: "Default Account");
  // }
}
