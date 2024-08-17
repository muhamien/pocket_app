import 'package:flutter/material.dart';
import 'package:pocket_app/model/pocket.dart';
import 'package:pocket_app/model/transaction.dart';
import 'package:pocket_app/presentations/main/home.dart';
import 'package:pocket_app/presentations/pocket/detail_pocket.dart';
import 'package:pocket_app/presentations/pocket/pocket_list.dart';
import 'package:pocket_app/presentations/transactions/detail_transaction.dart';
import 'package:pocket_app/presentations/transactions/transaction_list.dart';

class Routes {
  Routes._();

  static const String main = "/home";
  static const String detailPocket = "/detail_pocket";
  static const String detailTransaction = "/detail_transaction";
  static const String pocketList = "/pocket_list";
  static const String transactionList = "/transaction_list";

  static final routes = <String, WidgetBuilder>{
    main: (BuildContext context) => const HomeScreen(),
    detailPocket: (BuildContext context) {
      final pocket = ModalRoute.of(context)?.settings.arguments as Pocket;
      return DetailPocketScreen(pocket: pocket);
    },
    detailTransaction: (BuildContext context) {
      final transaction =
          ModalRoute.of(context)?.settings.arguments as Transaction;
      return DetailTransactionScreen(transaction: transaction);
    },
    pocketList: (BuildContext contex) => const PocketListScreen(),
    transactionList: (BuildContext contex) => const TransactionListScreen()
  };
}
