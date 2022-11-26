import 'package:hive/hive.dart';
import 'package:moneygram/category/model/category.dart';

abstract class CategoryLocalDataSource {
  Future<void> addCategory(Category category);
  Future<void> deleteCategory(int key);
  Future<List<Category>> categorys();
  Category fetchCategory(int categoryId);
  Box<Category> getBox();
  Future<Category?> fetchCategoryFromId(int categoryId);
}
