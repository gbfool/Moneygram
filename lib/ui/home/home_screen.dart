import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneygram/api/google_auth_client.dart';
import 'package:moneygram/api/google_signin_api.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/ui/add_transaction/add_transaction_page.dart';
import 'package:moneygram/ui/base_screen.dart';
import 'package:moneygram/ui/home/transaction_card_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:moneygram/viewmodels/home_screen_viewmodel.dart';
import 'package:moneygram/utils/transaction_extension.dart';

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
    return Column(
      children: [
        InkWell(
            onTap: () async {
              await GoogleSignInAPI.readFiles();
            },
            child: Container(
                padding: EdgeInsets.all(32),
                color: Colors.cyan,
                child: Text("Read here"))),
        const SizedBox(height: 12),
        InkWell(
            onTap: () async {
              await GoogleSignInAPI.deleteFiles();
            },
            child: Container(
                padding: EdgeInsets.all(32),
                color: Colors.cyan,
                child: Text("Delete here"))),
      ],
    );
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Column(
        children: <Widget>[_listWidget()],
      ),
    );
  }

  Widget _listWidget() {
    return Expanded(
        child: ListView.builder(
      itemCount: _homeScreenViewModel.transactionList.length + 1,
      itemBuilder: (context, index) {
        var maps = _homeScreenViewModel.transactionList;
        if (index == 0) {
          return Container(
              height: 200, child: Center(child: Text("No chart available")));
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
    await GoogleSignInAPI.upload();
    // showBarModalBottomSheet(
    //   context: context,
    //   backgroundColor: Colors.transparent,
    //   builder: (context) => AddTransactionPage(
    //     transaction: transaction,
    //   ),
    // );
  }

  @override
  void dispose() {
    _homeScreenViewModel.removeBoxListener();
    print("Removing this");
    super.dispose();
  }
}
