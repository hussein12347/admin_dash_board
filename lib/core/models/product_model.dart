import 'package:equatable/equatable.dart';

import 'favorite_product_model.dart';

class ProductModel extends Equatable{
  final String productId;
  final DateTime createdAt;
  final String productName;
  final String price;
  final String available_quantity;
  final String? oldPrice;

  final bool is_show;
  final String? offer_id;
  final String description;
  final String category_id;
  final int boughtTimes;
  final String? imageUrl;
  final String? delete_image_url;

  const ProductModel({
    required this.productId,
    required this.createdAt,
    required this.productName,
    required this.price,
    required this.available_quantity,
    this.oldPrice,
    this.is_show=true,
    this.offer_id,
    required this.description,
    required this.category_id,
    required this.boughtTimes,
    this.imageUrl,
    this.delete_image_url,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['product_id'],
      createdAt: DateTime.parse(json['created_at']),
      productName: json['product_name'],
      price: json['price'],
      available_quantity: json['available_quantity'],
      oldPrice: json['old_price'],
      is_show: json['is_show'],
      offer_id: json['offer_id'],
      description: json['description'],
      category_id: json['category_id'],
      boughtTimes: json['bought_times'],
      imageUrl: json['image_url'],
      delete_image_url: json['delete_image_url'],
    );
  }

  ProductModel copyWith({
    String? productName,
    String? price,
    String? oldPrice,
    String? available_quantity,
    String? description,
    String? category_id,
    int? boughtTimes,
    List<FavoriteProductModel>? favoriteProducts,
    String? productId,
    DateTime? createdAt,
    String? imageUrl,
    String? delete_image_url,
  }) {
    return ProductModel(
      productName: productName ?? this.productName,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      available_quantity: available_quantity ?? this.available_quantity,
      description: description ?? this.description,
      category_id: category_id ?? this.category_id,
      boughtTimes: boughtTimes ?? this.boughtTimes,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      delete_image_url: delete_image_url ?? this.delete_image_url,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
      'product_name': productName,
      'price': price,
      'available_quantity': available_quantity,
      'old_price': oldPrice,
      'is_show': is_show,
      'offer_id': offer_id,
      'description': description,
      'category_id': category_id,
      'bought_times': boughtTimes,
      'image_url': imageUrl,
      'delete_image_url': delete_image_url,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [productId];
}
