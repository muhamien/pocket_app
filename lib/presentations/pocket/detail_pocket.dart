import 'package:flutter/material.dart';
import 'package:pocket_app/model/pocket.dart';

class DetailPocketScreen extends StatefulWidget {
  final Pocket pocket;

  const DetailPocketScreen({
    super.key,
    required this.pocket,
  });

  @override
  DetailPocketScreenState createState() => DetailPocketScreenState();
}

class DetailPocketScreenState extends State<DetailPocketScreen> {
  String _formatCurrency(int amount) {
    return 'Rp.${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pocket Details",
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
              _buildDetailPocket(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailPocket(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              widget.pocket.logo,
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.pocket.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                Text(
                  _formatCurrency(widget.pocket.balance),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/pocketList');
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24.0),
            ),
            padding: const EdgeInsets.all(12),
            child: const Center(
              child: Icon(
                Icons.link_off,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
