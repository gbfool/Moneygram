import 'package:flutter/material.dart';
import 'package:moneygram/category/category_hive_helper.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/utils/custom_text_style.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';
import 'package:moneygram/utils/string_extension.dart';

class CategoryPickerScreen extends StatefulWidget {
  final Function(Category) onCategorySelected;
  const CategoryPickerScreen({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  State<CategoryPickerScreen> createState() => _CategoryPickerScreenState();
}

class _CategoryPickerScreenState extends State<CategoryPickerScreen> {
  TransactionType _selectedType = TransactionType.expense;
  List<Category> categoryList = [];
  List<Category> filterList = [];
  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  void fetchCategories() async {
    categoryList = await CategoryHiveHelper().getCategories();
    _filteredList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _body(),
        Positioned.fill(
            child:
                Align(alignment: Alignment.bottomCenter, child: _chipsRow())),
      ],
    );
  }

  Widget _body() {
    return Container(
        padding: EdgeInsets.only(top: 16, left: 12, right: 12),
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.3,
            maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                Text("Categories",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                ..._rows()
              ],
            )));
  }

  List<Widget> _rows() {
    List<Widget> rows = [];
    List<Widget> currentTiles = [];
    filterList.forEach((element) {
      var tile = _getTile(element);
      currentTiles.add(tile);
      if (currentTiles.length % 3 == 0) {
        rows.add(_getRow(currentTiles));
        currentTiles = [];
      }
    });
    if (currentTiles.isNotEmpty) {
      rows.add(_getRow(currentTiles));
    }
    return rows;
  }

  Widget _getTile(Category category) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          widget.onCategorySelected(category);
          Navigator.of(context).pop();
          // print(category);
        },
        child: Container(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.only(left: 6, right: 6, bottom: 6),
            padding: EdgeInsets.only(top: 14, bottom: 14),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(category.emoji,
                  style: CustomTextStyle.emojiStyle(fontSize: 24)),
              Flexible(
                child: Text(
                  category.name,
                  style: TextStyle(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ])),
      ),
    );
  }

  Widget _getRow(List<Widget> widgets) {
    if (widgets.length % 3 != 0) {
      widgets.add(Spacer());
    }
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: widgets),
    );
  }

  Widget _chipsRow() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: 32),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getChips(TransactionType.expense),
            const SizedBox(width: 12),
            _getChips(TransactionType.income),
          ],
        ),
      ),
    );
  }

  Widget _getChips(TransactionType type) {
    bool check = type == _selectedType;
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
          setState(() {
            _selectedType = type;
            _filteredList();
          });
        },
      ),
    );
  }

  void _filteredList() {
    filterList = categoryList
        .where((element) => element.transactionType == _selectedType)
        .toList();
  }
}
