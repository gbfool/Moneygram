import 'package:flutter/src/material/date.dart';
import 'package:hive/hive.dart';
import 'package:moneygram/transactions/data_sources/transaction_local_data_source.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/utils/enum/box_types.dart';

class TransactionManagerLocalDataSourceImpl
    implements TransactionManagerLocalDataSource {
  late final transactionBox =
      Hive.box<Transaction>(BoxType.transactions.stringValue);
  @override
  Future<void> addOrUpdateTransaction(Transaction transaction) {
    // TODO: implement addOrUpdateTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> clearTransaction(int key) {
    // TODO: implement clearTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> clearTransactions() {
    // TODO: implement clearTransactions
    throw UnimplementedError();
  }

  @override
  Future<Iterable<Transaction>> exportData() {
    // TODO: implement exportData
    throw UnimplementedError();
  }

  @override
  Future<Transaction?> fetchTransactionFromId(int transactionId) {
    // TODO: implement fetchTransactionFromId
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> filteredTransactions(DateTimeRange dateTimeRange) {
    // TODO: implement filteredTransactions
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> transactions() {
    // TODO: implement transactions
    throw UnimplementedError();
  }
}
