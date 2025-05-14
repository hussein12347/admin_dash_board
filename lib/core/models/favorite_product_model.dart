class FavoriteProductModel {
  final String id;
  final String forUser;
  final DateTime? createdAt;
  final String forProduct;

  FavoriteProductModel({
    required this.id,
    required this.forUser,
     this.createdAt,
    required this.forProduct,
  });

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductModel(
      id: json['id'],
      forUser: json['for_user'],
      createdAt: DateTime.parse(json['created_at']),
      forProduct: json['for_product'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'for_user': forUser,
      'created_at': createdAt?.toIso8601String(),
      'for_product': forProduct,
    };
  }
}
