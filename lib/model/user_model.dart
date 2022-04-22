class UserModel {
   String username;
   String? image;
   String? userId;
   String email;
   String mobileNumber;
   String role;

  UserModel(
      {required this.username,
      this.userId,
      this.image,
      required this.email,
      required this.mobileNumber,
      required this.role});

  Map<String, dynamic> toJson() => {
        "username": username,
        "image" : image,
        "userId": userId,
        "email": email,
        "mobileNumber": mobileNumber,
        "role": role
      };

  static UserModel formJson(Map<String, dynamic> json) => UserModel(
      username: json['username'],
      image: json['image'],
      userId: json['userId'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      role: json['role']);
}
