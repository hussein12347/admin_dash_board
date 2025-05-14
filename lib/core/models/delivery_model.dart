import 'dart:developer';

class DeliveryModel {
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

  DeliveryModel({
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
  });

  // من أجل تحويل البيانات من خريطة (Map) إلى كائن Dart
  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    try {
      return DeliveryModel(
        id: map['id'] ?? '', // استخدام قيمة افتراضية إذا كانت فارغة
        createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()), // استخدام التاريخ الحالي إذا كان غير موجود
        userId: map['user_id'] ?? '',
        name: map['name'] ?? '',
        phone: map['phone'] ?? '',
        address: map['address'] ?? '',
        isPaid: map['is_paid'] == true || map['is_paid'] == 'true', // معالجة الحقول التي قد تكون نصية
        totalPrice: map['total_price'] != null ? double.tryParse(map['total_price'].toString()) ?? 0.0 : 0.0, // تأكد من أن السعر قابل للتحويل إلى double
        number: map['number'] != null ? int.tryParse(map['number'].toString()) ?? 0 : 0, // تأكد من أن الرقم قابل للتحويل إلى int
        status: map['status'] != null ? int.tryParse(map['status'].toString()) ?? 0 : 0, // تأكد من أن الحالة قابلة للتحويل إلى int
      );
    } catch (e) {
      log("Error parsing delivery model: $e");
      rethrow; // إعادة رمي الخطأ بعد تسجيله
    }
  }


  // من أجل تحويل الكائن إلى خريطة (Map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'name': name,
      'phone': phone,
      'address': address,
      'is_paid': isPaid.toString(),
      'total_price': totalPrice.toString(),
      'number': number.toString(),
      'status': status.toString(),
    };
  }

  @override
  String toString() {
    return 'DeliveryModel{id: $id, createdAt: $createdAt, userId: $userId, name: $name, phone: $phone, address: $address, isPaid: $isPaid, totalPrice: $totalPrice, number: $number, status: $status}';
  }
}
