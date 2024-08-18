import 'package:flutter/material.dart';
import 'package:pocket_app/model/transaction.dart';
import 'package:pocket_app/utils/routes.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  String _formatCurrency(int amount) {
    return 'Rp.${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Transaction List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: transactionList.map((transaction) {
              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color.fromARGB(255, 209, 209, 209),
                  ),
                  padding: const EdgeInsets.all(8),
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Text(
                      transaction.merchant[0],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transaction.title,
                  style: const TextStyle(fontFamily: 'RobotoMono'),
                ),
                subtitle: Text(
                  transaction.date,
                  style: const TextStyle(fontFamily: 'RobotoMono'),
                ),
                trailing: Text(
                  _formatCurrency(transaction.amount),
                  style:
                      const TextStyle(fontFamily: 'RobotoMono', fontSize: 14),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.detailTransaction,
                      arguments: transaction);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
