import 'package:hive/hive.dart';
import 'package:moneygram/category/data_source/category_local_data_source.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/utils/enum/box_types.dart';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  late final CategoryBox = Hive.box<Category>(BoxType.category.stringValue);

  @override
  Future<void> addCategory(Category category) {
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
  Category fetchCategory(int categoryId) {
    // TODO: implement fetchCategory
    throw UnimplementedError();
  }

  @override
  Future<Category?> fetchCategoryFromId(int categoryId) {
    // TODO: implement fetchCategoryFromId
    throw UnimplementedError();
  }

  @override
  Box<Category> getBox() {
    // TODO: implement getBox
    throw UnimplementedError();
  }
}
