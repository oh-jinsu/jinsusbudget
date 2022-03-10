class PiggyBankModel {
  final int id;
  final int amount;

  PiggyBankModel({
    required this.id,
    required this.amount,
  });

  factory PiggyBankModel.fromMap(Map<String, dynamic> map) {
    return PiggyBankModel(
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
