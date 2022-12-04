import 'package:flutter/material.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  final List<Category> categoryList;
  final Function(Category) onCategorySelected;
  const CategoryScreen(
      {Key? key, required this.categoryList, required this.onCategorySelected})
      : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 16, left: 12, right: 12),
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.3,
            maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: SingleChildScrollView(
            child: Column(children: [
          Text("Categories",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ..._rows()
        ])));
  }

  List<Widget> _rows() {
    List<Widget> rows = [];
    List<Widget> currentTiles = [];
    widget.categoryList.forEach((element) {
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
              Text(category.emoji, style: GoogleFonts.notoEmoji(fontSize: 24)),
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
}
