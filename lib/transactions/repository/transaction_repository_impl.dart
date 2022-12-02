import 'package:hive/hive.dart';
import 'package:moneygram/transactions/data_sources/transaction_local_data_source.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/utils/currency_helper.dart';
import 'package:moneygram/utils/enum/filter_budget.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';
import 'package:moneygram/utils/enum/filter_days.dart';
import 'package:moneygram/utils/time_extension.dart';
import 'package:moneygram/utils/transaction_extension.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  TransactionRepositoryImpl({
    required this.dataSource,
  });

  List<Transaction> transactionsList = [];
  final TransactionManagerLocalDataSource dataSource;

  @override
  Future<void> addTransaction(String? notes, double amount, DateTime time,
      int categoryId, int accountId, TransactionType transactionType) async {
    var transaction = Transaction(
        notes: notes,
        amount: amount,
        time: time,
        categoryId: categoryId,
        accountId: accountId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        type: transactionType);
    await dataSource.addTransaction(transaction);
  }

  @override
  Future<Map<String, List<Transaction>>> getGroupedTransactions(
      bool isRefresh) async {
    final expenses = await fetchAndCache(isRefresh: isRefresh);
    expenses.sort((a, b) => b.time.compareTo(a.time));
    final Map<String, List<Transaction>> groupedExpense =
        expenses.groupByTime(FilterBudget.daily);
    return groupedExpense;
  }

  @override
  Future<List<Transaction>> getAllTransactions(bool isRefresh) async {
    final expenses = await fetchAndCache(isRefresh: isRefresh);
    return expenses;
  }

  @override
  Future<void> clearTransaction(int transactionId) async {
    dataSource.clearTransaction(transactionId);
  }

  @override
  Future<void> clearTransactions() async {
    dataSource.clearTransactions();
  }

  @override
  Future<Transaction?> fetchTransactionFromId(int transactionId) {
    return dataSource.fetchTransactionFromId(transactionId);
  }

  @override
  Future<String> filterTransactionTotal(FilterDays filterDays) async {
    final List<Transaction> transactions = await fetchAndCache();
    transactions.sort((a, b) => b.time.compareTo(a.time));
    final total = transactions
        .where((element) {
          final int days = element.time.daysDifference;
          return filterDays.filterDate(days);
        })
        .map((e) => e.amount)
        .fold<double>(0, (previousValue, element) => previousValue + element);
    return CurrencyHelper.formattedCurrency(total);
  }

  @override
  Future<String> totalTransactions(TransactionType type) async {
    final List<Transaction> transactions = await fetchAndCache();
    final total = transactions
        .where((element) => element.type == type)
        .map((e) => e.amount)
        .fold<double>(0, (previousValue, element) => previousValue + element);
    return CurrencyHelper.formattedCurrency(total);
  }

  Future<List<Transaction>> fetchAndCache({bool isRefresh = false}) async {
    if (transactionsList.isEmpty || isRefresh) {
      transactionsList = await dataSource.transactions();
    }
    return transactionsList;
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    await dataSource.updateTransaction(transaction);
  }

  @override
  Box<Transaction> getBox() {
    return dataSource.getBox();
  }
}
