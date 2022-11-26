import 'package:moneygram/transactions/data_sources/transaction_local_data_source.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';
import 'package:moneygram/utils/enum/filter_days.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  TransactionRepositoryImpl({
    required this.dataSource,
  });

  List<Transaction> TransactionsList = [];
  final TransactionManagerLocalDataSource dataSource;

  @override
  Future<void> addTransaction(String name, double amount, DateTime time,
      int category, int account, TransactionType transactionType) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> clearTransaction(int transactionId) {
    // TODO: implement clearTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> clearTransactions() {
    // TODO: implement clearTransactions
    throw UnimplementedError();
  }

  @override
  Future<Transaction?> fetchTransactionFromId(int transactionId) {
    // TODO: implement fetchTransactionFromId
    throw UnimplementedError();
  }

  @override
  Future<String> filterTransactionTotal(FilterDays filterDays) {
    // TODO: implement filterTransactionTotal
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<TransactionType>>> getAllTransactions(
      bool isRefresh) {
    // TODO: implement getAllTransactions
    throw UnimplementedError();
  }

  @override
  Future<String> totalTransactions(TransactionType type) {
    // TODO: implement totalTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
