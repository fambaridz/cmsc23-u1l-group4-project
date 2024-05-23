class Donor {
  String? id;
  String userType;
  String name;
  String username;
  String email;
  Map<String, String> addresses;
  String? contactNum;

  Donor({
    this.id,
    required this.userType,
    required this.name,
    required this.username,
    required this.email,
    required this.addresses,
    required this.contactNum,
  });
}
