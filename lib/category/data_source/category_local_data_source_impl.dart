import 'package:hive/hive.dart';
import 'package:moneygram/category/data_source/category_local_data_source.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/utils/enum/box_types.dart';
import 'package:collection/collection.dart';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  late final categoryBox = Hive.box<Category>(BoxType.category.stringValue);

  @override
  Future<void> addOrUpdateCategory(Category category) async {
    final int id = await categoryBox.add(category);
    category.id = id;
    await category.save();
  }

  @override
  Future<List<Category>> categories() async {
    final categories = categoryBox.values.toList();
    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }

  @override
  Future<void> deleteCategory(int key) async {
    // to delete a particular category, need to delete the corresponding transactions
    return categoryBox.delete(key);
  }

  @override
  Category fetchCategory(int categoryId) {
    return categoryBox.values.firstWhere((element) {
      return element.id == categoryId;
    });
  }

  @override
  Future<Category?> fetchCategoryFromId(int categoryId) async {
    var values = categoryBox.values;
    return values.firstWhereOrNull((element) {
      return element.id == categoryId;
    });
  }

  @override
  Box<Category> getBox() {
    return categoryBox;
  }
}
