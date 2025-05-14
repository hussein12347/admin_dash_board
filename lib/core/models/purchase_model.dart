class PurchaseModel {
  final String id;
  final String fprUser;
  final bool isBought;
  final DateTime createdAt;
  final String forProduct;

  PurchaseModel({
    required this.id,
    required this.fprUser,
    required this.isBought,
    required this.createdAt,
    required this.forProduct,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['id'],
      fprUser: json['fpr_user'],
      isBought: json['is_bought'],
      createdAt: DateTime.parse(json['created_at']),
      forProduct: json['for_product'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fpr_user': fprUser,
      'is_bought': isBought,
      'created_at': createdAt.toIso8601String(),
      'for_product': forProduct,
    };
  }
}
