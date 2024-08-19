import 'package:flutter/material.dart';
import 'package:pocket_app/model/pocket.dart';
import 'package:pocket_app/utils/routes.dart';

class PocketListScreen extends StatelessWidget {
  const PocketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Pocket List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildPocketListView(pocketList)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size.fromHeight(50), // Full width
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.link,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Add Pocket",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPocketListView(List<Pocket> pocketData) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: pocketData.length,
        itemBuilder: (context, index) {
          final pocket = pocketData[index];
          return _buildPocketListItem(context, pocket);
        },
      ),
    );
  }

  Widget _buildPocketListItem(BuildContext context, Pocket pocket) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.detailPocket, arguments: pocket);
      },
      child: Card(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 200, minWidth: 150),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(pocket.logo, width: 50),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '${pocket.balance}',
                    style: const TextStyle(
                        fontFamily: "RobotoMono",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.link_off,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
