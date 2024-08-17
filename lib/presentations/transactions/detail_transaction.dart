import 'package:flutter/material.dart';
import 'package:pocket_app/model/transaction.dart';

class DetailTransactionScreen extends StatelessWidget {
  final Transaction transaction;

  const DetailTransactionScreen({
    super.key,
    required this.transaction,
  });

  String _formatCurrency(int amount) {
    return 'Rp.${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono',
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailTransaction(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTransaction(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: const Color.fromARGB(255, 209, 209, 209),
              ),
              padding: const EdgeInsets.all(8),
              width: 50,
              height: 50,
              child: Center(
                child: Text(
                  transaction.merchant[0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                Text(
                  '-${_formatCurrency(transaction.amount)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
