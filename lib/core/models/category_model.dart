

class CategoryModel {
  final String id;
  final DateTime createdAt;
  final String name;
  final String? imageUrl;
  final String? deleteImage;
  final bool isShow;

  CategoryModel({
    required this.id,
    required this.createdAt,
    required this.name,
    this.imageUrl,
    this.deleteImage,
    this.isShow = true,
  });


  @override
  String toString() {
    return 'CategoryModel{id: $id, createdAt: $createdAt, name: $name, imageUrl: $imageUrl, deleteImage: $deleteImage, isShow: $isShow}';
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      imageUrl: json['image_url'],
      deleteImage: json['delete_image_url'],
      isShow: json['is_show'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'image_url': imageUrl,
      'delete_image_url': deleteImage,
      'is_show': isShow,
    };
  }

  CategoryModel copyWith({
    String? id,
    DateTime? createdAt,
    String? name,
    String? imageUrl,
    String? deleteImage,
    bool? isShow,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      deleteImage: deleteImage ?? this.deleteImage,
      isShow: isShow ?? this.isShow,
    );
  }
}
