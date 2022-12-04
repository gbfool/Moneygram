import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/ui/add_transaction/add_transaction_page.dart';
import 'package:moneygram/ui/base_screen.dart';
import 'package:moneygram/ui/home/transaction_card_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:moneygram/viewmodels/home_screen_viewmodel.dart';
import 'package:moneygram/utils/transaction_extension.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeScreenViewModel _homeScreenViewModel;
  @override
  Widget build(BuildContext context) {
    return BaseScreen<HomeScreenViewModel>(onModelReady: (model) {
      this._homeScreenViewModel = model;
      this._homeScreenViewModel.init();
    }, builder: (context, model, child) {
      return _content();
    });
  }

  Widget _content() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        // Use [SystemUiOverlayStyle.light] for white status bar
        // or [SystemUiOverlayStyle.dark] for black status bar
        // https://stackoverflow.com/a/58132007/1321917
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              )),
          body: SafeArea(
            child: _body(),
          ),
          floatingActionButton:
              _fab(), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          _timeRangeWidget(),
          const SizedBox(height: 12),
          _listWidget()
        ],
      ),
    );
  }

  Widget _timeRangeWidget() {
    var leftArrow = Container(
        height: 36,
        width: 36,
        alignment: Alignment.center,
        child: Icon(Icons.arrow_back, color: Colors.black.withOpacity(0.5)),
        decoration: BoxDecoration(
            color: Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(18)));
    var rightArrow = Container(
        height: 36,
        width: 36,
        alignment: Alignment.center,
        child: Icon(Icons.arrow_forward, color: Colors.black.withOpacity(0.5)),
        decoration: BoxDecoration(
            color: Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(18)));
    var rangeWidget = Text("1 Dec - 31 Dec");
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [leftArrow, rangeWidget, rightArrow]));
  }

  Widget _listWidget() {
    return Expanded(
        child: ListView.builder(
      itemCount: _homeScreenViewModel.transactionList.length + 1,
      itemBuilder: (context, index) {
        var maps = _homeScreenViewModel.transactionList;
        // if (index == 0) {
        //   return _topWidgetV2();
        // }
        if (index == 0) {
          return _topWidgetV2();
        }
        final transactions = maps.values.toList()[index - 1];
        transactions.sort((a, b) => b.time.compareTo(a.time));
        return TransactionCardWidget(
            title: maps.keys.toList()[index - 1],
            total: transactions.filterTotal,
            transactions: transactions,
            onTap: (transaction) {
              _openTransactionPage(transaction: transaction);
            });
        // if (index % 4 == 0) {
        //   return TransactionRowHeaderWidget();
        // }
        // return TransactionRowWidget(transaction: Utils.getDummyTransaction(), accountLocalDataSource: locator.get(), categoryLocalDataSource: locator.get());
      },
    ));
  }

  FloatingActionButton _fab() {
    return FloatingActionButton(
      onPressed: () => _openTransactionPage(),
      tooltip: 'Add Transaction',
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.add,
        size: 32,
        color: Colors.black,
      ),
    );
  }

  void _openTransactionPage({Transaction? transaction}) async {
    showBarModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTransactionPage(
        transaction: transaction,
      ),
    );
  }

  Widget _topWidgetV1() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildExpenseIncomeWidgetV1(),
          const SizedBox(width: 16),
          _buildExpenseIncomeWidgetV1()
        ],
      ),
    );
  }

  Widget _topWidgetV2() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Color(0xFFF4F4F4)),
      child: Column(
        children: [
          _buildExpenseIncomeWidgetV2(
              emoji: "💸", header: "Expenses", amount: "₹200"),
          const SizedBox(height: 16),
          _buildExpenseIncomeWidgetV2(
              emoji: "💰", header: "Income", amount: "₹90000")
        ],
      ),
    );
  }

  Widget _buildExpenseIncomeWidgetV1() {
    var textSpan = TextSpan(children: [
      TextSpan(
          text: "💸",
          style: GoogleFonts.notoEmoji(fontSize: 14, color: Colors.black)),
      TextSpan(text: " Expenses", style: TextStyle(color: Color(0xFF8c8c8c)))
    ]);
    var amountWidget = Text(
      "₹200",
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    );
    return Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Color(0xFFF4F4F4)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(text: textSpan),
                const SizedBox(height: 8),
                amountWidget
              ])),
    );
  }

  Widget _buildExpenseIncomeWidgetV2(
      {required String emoji, required String header, required String amount}) {
    var textSpan = TextSpan(children: [
      TextSpan(
          text: emoji,
          style: GoogleFonts.notoEmoji(fontSize: 18, color: Colors.black)),
      TextSpan(
          text: " $header",
          style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)))
    ]);
    var amountWidget = Text(
      amount,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    );
    return Row(children: [
      RichText(text: textSpan),
      Spacer(),
      const SizedBox(width: 12),
      amountWidget
    ]);
  }

  @override
  void dispose() {
    _homeScreenViewModel.removeBoxListener();
    print("-------------- Removing this --------------");
    super.dispose();
  }
}
