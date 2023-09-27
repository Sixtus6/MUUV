class User {
  final String uid;
  final String name;
  final String emailAddress;
  final String password;
  final String phone;
  final String address;

  User(
    this.password,
    this.phone,
    this.address, {
    required this.uid,
    required this.name,
    required this.emailAddress,
  });
}
