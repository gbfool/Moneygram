import 'package:moneygram/account/repository/account_repository.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';
import 'package:moneygram/viewmodels/base_view_model.dart';

class AddTransactionViewModel extends BaseViewModel {
  AddTransactionViewModel(
      {required this.transactionRepository,
      required this.accountRepository,
      required this.categoryRepository});

  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;
  final CategoryRepository categoryRepository;

  String? amount;
  String? transactionNotes;
  int? selectedCategoryId;
  int? selectedAccountId;
  DateTime? selectedDate;
  TransactionType transactionType = TransactionType.expense;
  Transaction? currentTransaction;

  void setValuesForTransaction(Transaction? transaction) {
    if (transaction == null) {
      return;
    }
    currentTransaction = transaction;
    amount = transaction.amount.toString();
    transactionNotes = transaction.notes;
    selectedCategoryId = transaction.categoryId;
    selectedAccountId = transaction.accountId;
    selectedDate = transaction.time;
    transactionType = transaction.type;
  }

  bool validate() {
    if (amount == null || amount!.isEmpty) {
      return false;
    }
    if (selectedAccountId == null) {
      return false;
    }
    if (selectedCategoryId == null) {
      return false;
    }
    return true;
  }

  void addTransaction() {
    double validAmount = double.parse(amount ?? "0");
    var date = selectedDate ?? DateTime.now();
    if (currentTransaction != null) {
      currentTransaction!
        ..accountId = selectedAccountId!
        ..categoryId = selectedCategoryId!
        ..amount = validAmount
        ..notes = transactionNotes
        ..time = date
        ..type = transactionType;
      transactionRepository.updateTransaction(currentTransaction!);
    } else {
      transactionRepository.addTransaction(transactionNotes, validAmount, date,
          selectedCategoryId!, selectedAccountId!, transactionType);
    }
  }
}
