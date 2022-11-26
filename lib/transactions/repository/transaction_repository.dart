import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/utils/enum/filter_days.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';

abstract class TransactionRepository {
  Future<Map<String, List<Transaction>>> getAllTransactions(bool isRefresh);
  Future<String> totalTransactions(TransactionType type);
  Future<String> filterTransactionTotal(FilterDays filterDays);
  Future<void> addTransaction(
    String? notes,
    double amount,
    DateTime time,
    int categoryId,
    int accountId,
    TransactionType transactionType,
  );
  Future<void> clearTransactions();
  Future<void> clearTransaction(int transactionId);
  Future<void> updateTransaction(Transaction transaction);
  Box<Transaction> getBox();
  Future<Transaction?> fetchTransactionFromId(int transactionId);
}
