class RiderModel {
  final String uid;
  final String name;
  final String emailAddress;
  final String password;
  final String phoneNumber;
  final String address;
  final String carModel;
  final String carColor;
  final String carPlateNumber;

  RiderModel({
    required this.carModel,
    required this.carColor,
    required this.carPlateNumber,
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
      'carModel': carModel,
      'carColor': carColor,
      'carPlateNum': carPlateNumber
    };
  }

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      emailAddress: json['emailAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      carColor: json['carColor'] as String,
      carModel: json['carModel'] as String,
      carPlateNumber: json['carPlateNum'] as String,
      password: json['password'] as String,
    );
  }
}
