import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/utils/enum/filter_days.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';

abstract class TransactionRepository {
  Future<Map<String, List<TransactionType>>> getAllTransactions(bool isRefresh);
  Future<String> totalTransactions(TransactionType type);
  Future<String> filterTransactionTotal(FilterDays filterDays);
  Future<void> addTransaction(
    String name,
    double amount,
    DateTime time,
    int category,
    int account,
    TransactionType transactionType,
  );
  Future<void> clearTransactions();
  Future<void> clearTransaction(int transactionId);
  Future<void> updateTransaction(Transaction transaction);

  Future<Transaction?> fetchTransactionFromId(int transactionId);
}
