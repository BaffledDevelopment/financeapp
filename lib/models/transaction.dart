class ExpenseTransaction {
  late String type;
  late String day;
  late String month;
  late String note;
  late String id;
  late int amount;
  late int categoryindex;

  ExpenseTransaction(
      // this.type,
      // this.day,
      // this.month,
      // this.memo,
      // this.id,
      // this.amount,
      // this.categoryindex
      );

  Map<String, dynamic> toJson() => {
    'type': type,
    'day': day,
    'month': month,
    'note': note,
    'id': id,
    'amount': amount,
    'categoryIndex': categoryindex};

  ExpenseTransaction.fromJson(Map<String, dynamic> json) :
        type = json['type'],
        day = json['day'],
        month = json['month'],
        note = json['note'],
        id = json['id'],
        amount = json['amount'],
        categoryindex = json['categoryIndex'];




}

