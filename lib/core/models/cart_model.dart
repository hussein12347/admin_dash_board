import 'package:admin_dash_board/core/models/product_model.dart';

class CartModel {
  final String id;
  final DateTime createdAt;
  final String userId;
  final String name;
  final String phone;
  final String address;
  final bool isPaid;
  final double totalPrice;
  final int number;
  final int status;
  final List<CartItemModel> cartItems;

  CartModel({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.isPaid,
    required this.totalPrice,
    required this.number,
    required this.status,
    required this.cartItems,
  });

  @override
  String toString() {
    return 'CartModel{id: $id, createdAt: $createdAt, userId: $userId, name: $name, phone: $phone, address: $address, isPaid: $isPaid, totalPrice: $totalPrice, number: $number, status: $status, cartItems: $cartItems}';
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      isPaid: json['is_paid'],
      totalPrice: json['total_price'].toDouble(),
      number: json['number'],
      status: json['status'],
      cartItems: (json['cart'] as List)
          .map((itemJson) => CartItemModel.fromJson(itemJson))
          .toList(),
    );
  }
}

class CartItemModel {
  final String id;
  final ProductModel product;
  final String fprUser;
  final String orderId;
  final int quantity;
  final DateTime createdAt;
  final String forProduct;

  CartItemModel({
    required this.id,
    required this.product,
    required this.fprUser,
    required this.orderId,
    required this.quantity,
    required this.createdAt,
    required this.forProduct,
  });

  @override
  String toString() {
    return 'CartItemModel{id: $id, product: $product, fprUser: $fprUser, orderId: $orderId, quantity: $quantity, createdAt: $createdAt, forProduct: $forProduct}';
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      fprUser: json['fpr_user'],
      orderId: json['order_id'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      forProduct: json['for_product'],
    );
  }
}
