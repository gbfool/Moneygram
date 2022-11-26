import 'package:moneygram/category/model/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> categorys();
  Future<void> addCategory({
    required String emoji,
    required String name,
  });
  Future<void> deleteCategory(int key);

  Future<void> updateCategory(Category category);

  Future<Category?> fetchCategoryFromId(int categoryId);
}
