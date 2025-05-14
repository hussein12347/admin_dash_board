class OfferModel {
  final String id;
  final DateTime createdAt;
  final String? imageUrl;
  final String? delete_image_url;
  final String? name;
  final bool isShow;

  OfferModel({
    required this.id,
    required this.createdAt,
    this.imageUrl,
    this.delete_image_url,
    this.name,
    required this.isShow,
  });

  OfferModel copyWith({
    String? id,
    DateTime? createdAt,
    String? imageUrl,
    String? delete_image_url,
    String? name,
    bool? isShow,
  }) {
    return OfferModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      delete_image_url: delete_image_url ?? this.delete_image_url,
      name: name ?? this.name,
      isShow: isShow ?? this.isShow,
    );
  }

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at']),
      imageUrl: json['image_url'],
      delete_image_url: json['delete_image_url'],
      name: json['name'],
      isShow: json['is_show'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'image_url': imageUrl,
      'delete_image_url': delete_image_url,
      'name': name,
      'is_show': isShow,
    };
  }
}
