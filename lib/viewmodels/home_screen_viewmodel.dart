import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneygram/account/repository/account_repository.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/utils/enum/box_types.dart';
import 'package:moneygram/viewmodels/base_view_model.dart';

class HomeScreenViewModel extends BaseViewModel {
  HomeScreenViewModel(
      {required this.transactionRepository,
      required this.accountRepository,
      required this.categoryRepository});
  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;
  final CategoryRepository categoryRepository;

  Map<String, List<Transaction>> transactionList = Map();

  void init() {
    setTransactions();
    listenToTransactionBox();
  }

  void setTransactions() async {
    transactionList = await transactionRepository.getAllTransactions(true);
    notifyListeners();
  }

  void listenToTransactionBox() {
    var listener = transactionRepository.getBox().listenable();
    listener.addListener(transactionListener);
  }

  void removeBoxListener() {
    var listner = Hive.box(BoxType.transactions.stringValue).listenable();
    listner.removeListener(transactionListener);
  }

  void transactionListener() {
    print("Adding here");
    setTransactions();
    notifyListeners();
  }
}
