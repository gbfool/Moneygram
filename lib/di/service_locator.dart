import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneygram/account/data_source/account_local_data_source.dart';
import 'package:moneygram/account/data_source/account_local_data_source_impl.dart';
import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/account/repository/account_repository.dart';
import 'package:moneygram/account/repository/account_repository_impl.dart';
import 'package:moneygram/category/data_source/category_local_data_source.dart';
import 'package:moneygram/category/data_source/category_local_data_source_impl.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/category/repository/category_repository_impl.dart';
import 'package:moneygram/transactions/data_sources/transaction_local_data_source.dart';
import 'package:moneygram/transactions/data_sources/transaction_local_data_source_impl.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/transactions/repository/transaction_repository_impl.dart';
import 'package:moneygram/utils/enum/box_types.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await _setupHive();
  _localSources();
  _setupRepository();
}

Future<void> _setupHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(TransactionAdapter())
    ..registerAdapter(TransactionTypeAdapter())
    ..registerAdapter(AccountAdapter())
    ..registerAdapter(CategoryAdapter());

  final transactionBox =
      await Hive.openBox<Transaction>(BoxType.transactions.stringValue);
  locator.registerLazySingleton<Box<Transaction>>(() => transactionBox);

  final categoryBox =
      await Hive.openBox<Category>(BoxType.category.stringValue);
  locator.registerLazySingleton<Box<Category>>(() => categoryBox);

  final accountBox = await Hive.openBox<Account>(BoxType.accounts.stringValue);
  locator.registerLazySingleton<Box<Account>>(() => accountBox);
}

void _localSources() {
  locator.registerLazySingleton<TransactionManagerLocalDataSource>(
      () => TransactionManagerLocalDataSourceImpl());
  locator.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl());
  locator.registerLazySingleton<AccountLocalDataSource>(
      () => AccountLocalDataSourceImpl());
}

void _setupRepository() {
  locator.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      dataSource: locator.get(),
    ),
  );
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      dataSource: locator.get(),
    ),
  );
  locator.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(
      dataSource: locator.get(),
    ),
  );
}
