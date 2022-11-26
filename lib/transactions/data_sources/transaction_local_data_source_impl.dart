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
  Future<void> addOrUpdateTransaction(Transaction transaction) async {
    final id = await transactionBox.add(transaction);
    print("\n===================\nSaving...\n");
    print(transaction.toJson());
    print("\n===================\n");
    transaction.id = id;
    transaction.save();
  }

  @override
  Future<List<Transaction>> transactions() async {
    return transactionBox.values.toList();
  }

  @override
  Future<void> clearTransaction(int key) async {
    await transactionBox.delete(key);
  }

  @override
  Future<void> clearTransactions() async {
    await transactionBox.clear();
  }

  @override
  Future<Transaction?> fetchTransactionFromId(int transactionId) async {
    return transactionBox.get(transactionId);
  }

  @override
  Future<List<Transaction>> filteredTransactions(
      DateTimeRange dateTimeRange) async {
    final List<Transaction> transactions = transactionBox.values.toList();
    transactions.sort((a, b) => b.time.compareTo(a.time));
    final filteredTransactions = transactions.takeWhile((value) {
      return value.time.isAfter(dateTimeRange.start) &&
          value.time.isBefore(dateTimeRange.end);
    }).toList();
    return filteredTransactions;
  }

  @override
  Box<Transaction> getBox() {
    return transactionBox;
  }
}
