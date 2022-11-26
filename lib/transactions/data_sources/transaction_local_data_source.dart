import 'package:flutter/material.dart';
import 'package:moneygram/transactions/models/transaction.dart';

abstract class TransactionManagerLocalDataSource {
  Future<void> addOrUpdateTransaction(Transaction transaction);
  Future<List<Transaction>> transactions();
  Future<List<Transaction>> filteredTransactions(DateTimeRange dateTimeRange);
  Future<void> clearTransactions();
  Future<void> clearTransaction(int key);
  Future<Transaction?> fetchTransactionFromId(int transactionId);
  Future<Iterable<Transaction>> exportData();
}
