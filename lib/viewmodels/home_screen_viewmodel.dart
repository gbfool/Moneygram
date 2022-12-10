import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneygram/account/repository/account_repository.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/ui/home/models/timeline.dart';
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
  ValueListenable<Box<Transaction>>? _valueListenable;
  late Timeline timeline;

  void init() {
    timeline = Timeline.currentWeek();
    setTransactions();
    listenToTransactionBox();
  }

  void setTransactions() async {
    transactionList = await transactionRepository.getGroupedTransactions(true);
    notifyListeners();
  }

  void listenToTransactionBox() {
    _valueListenable = transactionRepository.getBox().listenable();
    _valueListenable?.addListener(transactionListener);
  }

  void removeBoxListener() {
    _valueListenable?.removeListener(transactionListener);
  }

  void transactionListener() {
    print("Adding here");
    setTransactions();
  }

  void previousDate() {
    timeline = timeline.previousWeek();
    notifyListeners();
  }

  void nextDate() {
    timeline = timeline.nextWeek();
    notifyListeners();
  }
}
