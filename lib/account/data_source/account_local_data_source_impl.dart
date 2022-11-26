import 'package:hive/hive.dart';
import 'package:moneygram/account/data_source/account_local_data_source.dart';
import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/utils/enum/box_types.dart';

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  late final accountBox = Hive.box<Account>(BoxType.accounts.stringValue);

  @override
  Future<List<Account>> accounts() {
    // TODO: implement accounts
    throw UnimplementedError();
  }

  @override
  Future<void> addAccount(Account account) {
    // TODO: implement addAccount
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount(int key) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Account fetchAccount(int accountId) {
    // TODO: implement fetchAccount
    throw UnimplementedError();
  }

  @override
  Future<Account?> fetchAccountFromId(int accountId) {
    // TODO: implement fetchAccountFromId
    throw UnimplementedError();
  }

  @override
  Box<Account> getBox() {
    // TODO: implement getBox
    throw UnimplementedError();
  }
}
