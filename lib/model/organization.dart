class Organization {
  String? id;
  String userType;
  String name;
  String aboutUs;
  String username;
  String email;
  Map<String, String> addresses;
  String? contactNum;
  bool status;
  String? proof;

  Organization({
    this.id,
    required this.userType,
    required this.name,
    required this.aboutUs,
    required this.username,
    required this.email,
    required this.addresses,
    required this.contactNum,
    required this.status,
    required this.proof,
  });
}
