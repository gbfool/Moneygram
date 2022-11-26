import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/category/category_hive_helper.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/ui/base_screen.dart';
import 'package:moneygram/ui/category/category_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:moneygram/viewmodels/action_widget_view_model.dart';
import 'package:moneygram/viewmodels/add_transaction_view_model.dart';
import 'package:provider/provider.dart';

class ActionsWidget extends StatefulWidget {
  final TextEditingController notesTextController;
  const ActionsWidget({Key? key, required this.notesTextController})
      : super(key: key);

  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  late AddTransactionViewModel _addTransactionViewModel;
  late ActionWidgetViewModel _actionWidgetViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<ActionWidgetViewModel>(onModelReady: (model) {
      _addTransactionViewModel =
          Provider.of<AddTransactionViewModel>(context, listen: false);
      model.setValues(
          categoryId: _addTransactionViewModel.selectedCategoryId,
          accountId: _addTransactionViewModel.selectedAccountId);
      _actionWidgetViewModel = model;
    }, builder: (context, model, child) {
      return _content();
    });
  }

  Container _content() {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Column(
        children: [
          Row(children: [
            Text("Today"),
            const SizedBox(width: 4),
            const Text(
              '\u2022',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 4),
            Expanded(child: _inputField())
          ]),
          SizedBox(height: 6),
          Divider(height: 1, thickness: 0),
          _accountCategory(),
          Divider(height: 1, thickness: 0)
        ],
      ),
    );
  }

  Widget _inputField() {
    return TextField(
      controller: widget.notesTextController,
      cursorColor: Colors.black,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: "Add notes"),
    );
  }

  Widget _accountCategory() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _emojiWidget(category: _actionWidgetViewModel.getAccount()),
      SizedBox(width: 12),
      Icon(Icons.arrow_forward),
      SizedBox(width: 12),
      _emojiWidget(category: _actionWidgetViewModel.getCategory()),
    ]);
  }

  Widget _emojiWidget({required Category category}) {
    List<Widget> widgets = [
      Text(category.emoji, style: GoogleFonts.notoEmoji(fontSize: 24)),
      SizedBox(width: 4),
      Flexible(
        child: Text(
          category.name,
          style: TextStyle(fontSize: 16),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )
    ];
    return InkWell(
        onTap: () {
          _openCategoryPage(category);
        },
        child: Container(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Row(mainAxisSize: MainAxisSize.min, children: widgets)));
  }

  void _openCategoryPage(Category category) async {
    List<Category> list = await CategoryHiveHelper().getCategories();
    showBarModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: CategoryScreen(categoryList: list)));
  }
}
