class Donor {
  String id;
  String name;
  String username;
  String password;
  String address;
  String contactNo;
  List<String> donations;

  Donor(
      {required this.id,
      required this.name,
      required this.username,
      required this.password,
      required this.address,
      required this.contactNo,
      required this.donations});
}
