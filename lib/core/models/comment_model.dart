class CommentModel {
  String? id;
  String? createdAt;
  String? forUser;
  String? comment;
  String? forProduct;
  String? replay;
  String? userName;

  CommentModel(
      {this.id, this.createdAt, this.forUser, this.comment, this.forProduct, this.replay, this.userName});

  CommentModel copyWith(
      {String? id, String? createdAt, String? forUser, String? comment, String? forProduct, dynamic replay, String? userName}) =>
      CommentModel(id: id ?? this.id,
          createdAt: createdAt ?? this.createdAt,
          forUser: forUser ?? this.forUser,
          comment: comment ?? this.comment,
          forProduct: forProduct ?? this.forProduct,
          replay: replay ?? this.replay,
          userName: userName ?? this.userName);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["created_at"] = createdAt;
    map["for_user"] = forUser;
    map["comment"] = comment;
    map["for_product"] = forProduct;
    map["replay"] = replay;
    map["user_name"] = userName;
    return map;
  }
  CommentModel.fromJson(dynamic json){
    id = json["id"];
    createdAt = json["created_at"];
    forUser = json["for_user"];
    comment = json["comment"];
    forProduct = json["for_product"];
    replay = json["replay"];
    userName = json["user_name"];
  }

}