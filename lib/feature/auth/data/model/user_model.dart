class UserModel {
  static const String collectionName = 'users';
  UserModel({this.id, this.userName, this.email});
  String? id;
  String? userName;
  String? email;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': userName,
    'email': email,
  };
}
