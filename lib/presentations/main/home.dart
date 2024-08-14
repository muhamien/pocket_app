import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _buildTitle(),
                const SizedBox(height: 12),
                _buildTotalBalance(),
                const SizedBox(height: 12),
                _buildPocketListView(),
                const SizedBox(height: 12),
                _buildFinancialTips(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Financial Pocket",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 52,
        fontFamily: 'RobotoMono',
      ),
    );
  }

  Widget _buildTotalBalance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          children: [
            Text(
              "Rp400K",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 32,
                fontFamily: 'RobotoMono',
              ),
            ),
            Text(
              "Total Balance",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'RobotoMono',
              ),
            ),
          ],
        ),
        InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(18),
            child: const Icon(Icons.link, size: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildPocketListView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Pocket", style: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 8),
        // _buildPocketList()
        Row(
          children: [
            Card(
              child: Container(
                
                height: 120,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('images/gopay.png',width: 50),
                    const Text("Gopay")
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                
                height: 120,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('images/dana.png',width: 50),
                    const Text("Gopay")
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                
                height: 120,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('images/ovo.png',width: 50),
                    const Text("Gopay")
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                
                height: 120,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('images/ShopeePay.png',width: 50),
                    const Text("Gopay")
                  ],
                ),
              ),
            ),
          ],
        ),
      ]
    );
  }

  Widget _buildFinancialTips(){
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('images/gopay.png',width: 50),
            const Text("Gopay")
          ],
        ),
      ),
    );
  }

}
