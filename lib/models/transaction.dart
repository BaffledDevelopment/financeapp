class Transaction {
  final String type;
  final String day;
  final String month;
  final String memo;
  final int id;
  final int amount;
  final int categoryindex;

  Transaction(
      {required this.type,
      required this.day,
      required this.month,
      required this.memo,
      required this.id,
      required this.amount,
      required this.categoryindex});
}
