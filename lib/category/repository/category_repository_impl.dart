import 'package:moneygram/category/data_source/category_local_data_source.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/category/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl({required this.dataSource});

  final CategoryLocalDataSource dataSource;

  @override
  Future<void> addCategory(
      {required String emoji, required String name}) async {
    var category = Category(
        name: name,
        emoji: emoji);
    await dataSource.addOrUpdateCategory(category);
  }

  @override
  Future<List<Category>> categories({bool isSort = true}) async {
    var list = await dataSource.categories();
    if (isSort) {
      list.sort((a, b) => a.name.compareTo(b.name));
    }
    return list;
  }

  @override
  Future<void> deleteCategory(int key) {
    return dataSource.deleteCategory(key);
  }

  @override
  Future<Category?> fetchCategoryFromId(int categoryId) {
    return dataSource.fetchCategoryFromId(categoryId);
  }

  @override
  Future<void> updateCategory(Category category) {
    return dataSource.addOrUpdateCategory(category);
  }
}
