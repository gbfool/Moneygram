import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/ui/base_screen.dart';
import 'package:moneygram/ui/category/add_edit_category_screen.dart';
import 'package:moneygram/utils/custom_text_style.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';
import 'package:moneygram/utils/string_extension.dart';
import 'package:moneygram/viewmodels/manage_category_view_model.dart';

class ManageCategoryScreen extends StatefulWidget {
  const ManageCategoryScreen({super.key});

  @override
  State<ManageCategoryScreen> createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  late ManageCategoryViewModel _manageCategoryViewModel;

  int? groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return BaseScreen<ManageCategoryViewModel>(
        onModelReady: (model) {
          _manageCategoryViewModel = model;
          _manageCategoryViewModel.initState();
        },
        builder: (context, model, child) => _scaffold());
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          title: Text("Categories")),
      body: _body(),
      floatingActionButton: _fab(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _listView(),
        Positioned.fill(
            child:
                Align(alignment: Alignment.bottomCenter, child: _chipsRow())),
      ],
    );
  }

  Widget _listView() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          padding:
              const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 100),
          itemCount: _manageCategoryViewModel.filteredCategories.length,
          itemBuilder: (context, index) {
            return _row(_manageCategoryViewModel.filteredCategories[index]);
          }),
    );
  }

  Widget _chipsRow() {
    return SafeArea(
      child: CustomSlidingSegmentedControl<int>(
        initialValue: groupValue,
        padding: 18,
        children: {0: Text('Expense'), 1: Text('Income')},
        decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(
                0.0,
                2.0,
              ),
            ),
          ],
        ),
        thumbDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 2.0,
              spreadRadius: 0.5,
              offset: Offset(
                0.0,
                2.0,
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInToLinear,
        onValueChanged: (int? value) {
          groupValue = value;
          var type =
              value == 0 ? TransactionType.expense : TransactionType.income;
          setState(() {
            _manageCategoryViewModel.setTransactionType(type);
          });
        },
      ),
    );
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: CupertinoSlidingSegmentedControl<int>(
          backgroundColor: Colors.black.withOpacity(0.3),
          thumbColor: CupertinoColors.black.withOpacity(0.9),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          groupValue: groupValue,
          children: {
            0: buildSegment("Expense"),
            1: buildSegment("Income"),
          },
          onValueChanged: (value) {
            setState(() {
              groupValue = value;
            });
          },
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.only(bottom: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getChips(TransactionType.expense),
          const SizedBox(width: 12),
          _getChips(TransactionType.income),
        ],
      ),
    );
  }

  Widget buildSegment(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _getChips(TransactionType type) {
    bool check = type == _manageCategoryViewModel.selectedTransactionType;
    return Container(
      child: FilterChip(
        showCheckmark: false,
        selectedColor: Colors.black,
        pressElevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        backgroundColor: Colors.grey[300],
        label: Text(
          type.nameString.capitalize(),
          style: TextStyle(
              fontSize: 16,
              color: check ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600),
        ),
        selected: check,
        onSelected: (bool selected) {
          _manageCategoryViewModel.setTransactionType(type);
        },
      ),
    );
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
                Text(
                  category.name,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            const SizedBox(height: 12),
            Divider(height: 0, thickness: 0)
          ],
        ),
      ),
    );
  }

  void _openAddEditCategoryScreen({Category? category}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditCategoryScreen(
              category: category,
              addOrEditPerformed: () => _manageCategoryViewModel.initState(),
            )));
  }

  Widget _fab() {
    return FloatingActionButton(
      onPressed: () => _openAddEditCategoryScreen(),
      tooltip: 'Add Category',
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.add,
        size: 32,
        color: Colors.black,
      ),
    );
  }
}
