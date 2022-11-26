import 'package:moneygram/account/data_source/account_local_data_source.dart';
import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/account/repository/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final AccountLocalDataSource dataSource;

  @override
  Future<List<Account>> accounts() {
    // TODO: implement accounts
    throw UnimplementedError();
  }

  @override
  Future<void> addAccount({required String emoji, required String name}) {
    // TODO: implement addAccount
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount(int key) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Account?> fetchAccountFromId(int accountId) {
    // TODO: implement fetchAccountFromId
    throw UnimplementedError();
  }

  @override
  Future<void> updateAccount(Account account) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }
}
