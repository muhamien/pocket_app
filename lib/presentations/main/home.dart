import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_app/model/pocket.dart';
import 'package:pocket_app/model/transaction.dart';
import 'package:pocket_app/utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Pocket> pocketData;
  late List<Transaction> transactionData;

  Map addPocketData = {"pocketId": "", "balance": 0};

  int _calculateTotalBalance() {
    int totalBalance = 0;
    for (var pocket in pocketList) {
      totalBalance += pocket.balance;
    }
    return totalBalance;
  }

  String _formatCurrency(int amount) {
    return 'Rp.${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  void initState() {
    super.initState();
    pocketData = pocketList;
    transactionData = transactionList;
  }

  void _showAddBalanceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Balance",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'RobotoMono',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Pocket>(
                decoration: InputDecoration(
                  labelText: 'Select Pocket',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: pocketData.map((Pocket pocket) {
                  return DropdownMenuItem<Pocket>(
                    value: pocket,
                    child: Text(pocket.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    addPocketData['pocketId'] = value?.pocketId;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    addPocketData['amount'] = value.replaceAll(',', '.');
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: const Size.fromHeight(50), // Full width
                ),
                onPressed: () {
                  _updateTopupData();
                  setState(() {});
                },
                child: const Text(
                  "Top up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateTopupData() {
    final Pocket pocketSelected = pocketData.firstWhere(
      (pocket) => pocket.pocketId == addPocketData['pocketId'],
    );

    if (pocketSelected != null) {
      setState(() {
        final updatedPocket = Pocket(
          pocketId: pocketSelected.pocketId,
          name: pocketSelected.name,
          logo: pocketSelected.logo,
          balance: pocketSelected.balance + int.parse(addPocketData['amount']),
        );
        pocketData[pocketData.indexOf(pocketSelected)] = updatedPocket;
      });
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: <Widget>[
                _buildTitle(),
                const SizedBox(height: 12),
                _buildTotalBalance(),
                const SizedBox(height: 24),
                _buildConnectedPocketListView(context),
                const SizedBox(height: 12),
                _buildTransactionCard(context),
                const SizedBox(height: 12),
                _buildFinancialTipsCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Financial Pocket",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 52,
          fontFamily: 'RobotoMono',
        ),
      ),
    );
  }

  Widget _buildTotalBalance() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatCurrency(_calculateTotalBalance()),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  fontFamily: 'RobotoMono',
                ),
              ),
              const SizedBox(
                child: Text(
                  "Total Balances",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(18),
                  child: const Icon(
                    Icons.link,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  _showAddBalanceModal(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(18),
                  child: const Icon(
                    Icons.add,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedPocketListView(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Connected Pocket",
            style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 20,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      const SizedBox(height: 8),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.detailPocket);
                },
                child: Row(
                  children: pocketData.map<Widget>((pocket) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.detailPocket, arguments: pocket);
                      },
                      child: Card(
                        child: Container(
                          height: 120,
                          constraints: const BoxConstraints(
                              maxWidth: 200, minWidth: 150),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(pocket.logo, width: 50),
                              Text(
                                _formatCurrency(pocket.balance),
                                style:
                                    const TextStyle(fontFamily: "RobotoMono"),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Card(
                color: Colors.black,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.pocketList);
                  },
                  child: Container(
                    height: 120,
                    constraints:
                        const BoxConstraints(maxWidth: 200, minWidth: 150),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "See More",
                          style: TextStyle(
                              fontFamily: "RobotoMono",
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.chevron_right, size: 28),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildTransactionCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transactions",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "RobotoMono",
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.transactionList);
                    },
                    child: const Icon(
                      Icons.chevron_right,
                      size: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: transactionData.take(3).map((transaction) {
                  return Column(
                    children: [
                      _buildTransactionItem(context, transaction),
                      const SizedBox(height: 14),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction transaction) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.detailTransaction, arguments: transaction);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
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
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: "RobotoMono"),
                  ),
                  Text(
                    transaction.date,
                    style:
                        const TextStyle(fontSize: 12, fontFamily: "RobotoMono"),
                  ),
                ],
              ),
            ],
          ),
          Text(
            _formatCurrency(transaction.amount),
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: "RobotoMono"),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialTipsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: const AssetImage('images/financial-tips.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        BlendMode.multiply),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Article",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "RobotoMono",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Text(
                        "How to financial managing",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.chevron_right, size: 28),
                        ),
                      ),
                    ],
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
