import 'package:moneygram/account/repository/account_repository.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/viewmodels/base_view_model.dart';

class HomeScreenViewModel extends BaseViewModel {
  HomeScreenViewModel(
      {required this.transactionRepository,
      required this.accountRepository,
      required this.categoryRepository});
  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;
  final CategoryRepository categoryRepository;

  void getAllTransactions() async {
    var transactions = await transactionRepository.getAllTransactions(true);
    print(transactions);
  }
}
