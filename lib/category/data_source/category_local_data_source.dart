import 'package:hive/hive.dart';
import 'package:moneygram/category/model/category.dart';

abstract class CategoryLocalDataSource {
  Future<void> addOrUpdateCategory(Category category);
  Future<void> deleteCategory(int key);
  Future<List<Category>> categories();
  Category fetchCategory(int categoryId);
  Box<Category> getBox();
  Future<Category?> fetchCategoryFromId(int categoryId);
}