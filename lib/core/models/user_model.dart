
class UserModel {
  String id;
  String email;
  String name;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  // Factory method to create a User object from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
