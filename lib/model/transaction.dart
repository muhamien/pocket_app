class Transaction {
  final String merchant;
  final String title;
  final String date;
  final int amount;
  final String pocket;
  final String noTransaction;

  Transaction({
    required this.merchant,
    required this.title,
    required this.date,
    required this.amount,
    required this.pocket,
    required this.noTransaction,
  });
}

var transactionList = [
  Transaction(
    merchant: "Starbucks",
    title: "Coffee",
    date: "August 17, 2024",
    amount: 23000,
    pocket: "Gopay",
    noTransaction: "TXN12345",
  ),
  Transaction(
    merchant: "Soto Ayam",
    title: "Lunch",
    date: "August 17, 2024",
    amount: 18000,
    pocket: "OVO",
    noTransaction: "TXN67890",
  ),
  Transaction(
    merchant: "Ayam Geprek",
    title: "Dinner",
    date: "August 17, 2024",
    amount: 30000,
    pocket: "ShopeePay",
    noTransaction: "TXN54321",
  ),
  Transaction(
    merchant: "Indomaret",
    title: "Groceries",
    date: "August 16, 2024",
    amount: 50000,
    pocket: "Dana",
    noTransaction: "TXN09876",
  ),
  Transaction(
    merchant: "Grab",
    title: "Transport",
    date: "August 16, 2024",
    amount: 15000,
    pocket: "Gopay",
    noTransaction: "TXN11223",
  ),
];
