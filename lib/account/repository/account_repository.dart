import 'package:moneygram/account/model/account.dart';

abstract class AccountRepository {
  Future<List<Account>> accounts();
  Future<void> addAccount({
    required String emoji,
    required String name,
  });
  Future<void> deleteAccount(int key);

  Future<void> updateAccount(Account account);

  Future<Account?> fetchAccountFromId(int accountId);
}
