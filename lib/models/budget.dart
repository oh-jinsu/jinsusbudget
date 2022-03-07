class BudgetModel {
  final int id;
  final int amount;

  BudgetModel({
    required this.id,
    required this.amount,
  });

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map["id"],
      amount: map["amount"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
    };
  }
}
