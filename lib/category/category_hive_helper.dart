import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/di/service_locator.dart';
import 'package:moneygram/utils/utils.dart';

class CategoryHiveHelper {
  final CategoryRepository _categoryRepository = locator<CategoryRepository>();

  void addCategoriesInHive() async {
    List<Category> list = Utils.getExpensesCategory();
    for (var category in list) {
      _categoryRepository.addCategory(
          name: category.name, emoji: category.emoji);
    }
  }

  Future<List<Category>> getCategories() async {
    return _categoryRepository.categories();
  }
}
