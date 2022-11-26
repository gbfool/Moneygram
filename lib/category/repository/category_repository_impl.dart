import 'package:moneygram/category/data_source/category_local_data_source.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/category/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl({required this.dataSource});

  final CategoryLocalDataSource dataSource;

  @override
  Future<void> addCategory({required String emoji, required String name}) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> categorys() {
    // TODO: implement categorys
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(int key) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<Category?> fetchCategoryFromId(int categoryId) {
    // TODO: implement fetchCategoryFromId
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(Category category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
