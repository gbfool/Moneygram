import 'package:intl/intl.dart';
import 'package:moneygram/transactions/data_sources/transaction_local_data_source.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/utils/currency_helper.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';
import 'package:moneygram/utils/enum/filter_days.dart';
import 'package:moneygram/utils/list_utils.dart';
import 'package:moneygram/utils/time_extension.dart';

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
        type: transactionType);
    await dataSource.addOrUpdateTransaction(transaction);
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
  Future<Map<String, List<Transaction>>> getAllTransactions(
      bool isRefresh) async {
    final expenses = await fetchAndCache(isRefresh: isRefresh);
    expenses.sort((a, b) => b.time.compareTo(a.time));
    final Map<String, List<Transaction>> groupedExpense = groupBy(
        expenses, (Transaction expense) => _readableMonth(expense.time));
    return groupedExpense;
  }

  String _readableMonth(DateTime time) {
    return DateFormat('MMMM').format(time);
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
    await dataSource.addOrUpdateTransaction(transaction);
  }
}
