class UserModel {
  final String uid;
  final String name;
  final String emailAddress;
  final String password;
  final String phoneNumber;
  final String address;

  UserModel({
    required this.uid,
    required this.name,
    required this.emailAddress,
    required this.password,
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'emailAddress': emailAddress,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
    );
  }
}
