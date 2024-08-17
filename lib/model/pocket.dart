class Pocket {
  final int pocketId;
  final String name;
  final String logo;
  final int balance;

  Pocket({
    required this.pocketId,
    required this.name,
    required this.logo,
    required this.balance,
  });
}

var pocketList = [
  Pocket(pocketId: 1, name: "Gopay", logo: "images/gopay.png", balance: 150000),
  Pocket(pocketId: 2, name: "OVO", logo: "images/ovo.png", balance: 100000),
  Pocket(
      pocketId: 3,
      name: "ShopeePay",
      logo: "images/ShopeePay.png",
      balance: 200000),
  Pocket(pocketId: 4, name: "Dana", logo: "images/dana.png", balance: 10000),
];
