import 'package:flutter/material.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/ui/base_screen.dart';
import 'package:moneygram/ui/category/add_edit_category_screen.dart';
import 'package:moneygram/utils/custom_text_style.dart';
import 'package:moneygram/viewmodels/manage_category_view_model.dart';

class ManageCategoryScreen extends StatefulWidget {
  const ManageCategoryScreen({super.key});

  @override
  State<ManageCategoryScreen> createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  late ManageCategoryViewModel _manageCategoryViewModel;
  @override
  Widget build(BuildContext context) {
    return BaseScreen<ManageCategoryViewModel>(
        onModelReady: (model) {
          _manageCategoryViewModel = model;
          _manageCategoryViewModel.fetchCategories();
        },
        builder: (context, model, child) => _scaffold());
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Categories")),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView.builder(
        itemCount: _manageCategoryViewModel.expenseCategories.length,
        itemBuilder: (context, index) {
          return _row(_manageCategoryViewModel.expenseCategories[index]);
        });
  }

  Widget _row(Category category) {
    return InkWell(
      onTap: () => _openAddEditCategoryScreen(category: category),
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Column(
          children: [
            Row(
              children: [
                Text(category.emoji,
                    style: CustomTextStyle.emojiStyle(fontSize: 24)),
                SizedBox(width: 12),
                Text(category.name)
              ],
            ),
            const SizedBox(height: 12),
            Divider(height: 0, thickness: 0)
          ],
        ),
      ),
    );
  }

  void _openAddEditCategoryScreen({required Category category}) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddEditCategoryScreen(category: category)));
  }
}
