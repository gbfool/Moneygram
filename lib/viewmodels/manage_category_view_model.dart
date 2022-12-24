import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';
import 'package:moneygram/viewmodels/base_view_model.dart';

class ManageCategoryViewModel extends BaseViewModel {
  ManageCategoryViewModel({required this.categoryRepository});

  final CategoryRepository categoryRepository;
  List<Category> expenseCategories = [];
  List<Category> incomeCategories = [];

  void fetchCategories() async {
    expenseCategories = [];
    incomeCategories = [];
    var categories = await categoryRepository.categories();
    for (var category in categories) {
      if (category.transactionType == TransactionType.expense) {
        expenseCategories.add(category);
      } else {
        incomeCategories.add(category);
      }
    }
    notifyListeners();
  }
}
