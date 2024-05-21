class DonationDrive {
  String? id;
  String name;
  bool status;
  String orgId;
  List<String> donationList;

  DonationDrive(
      {this.id,
      required this.name,
      required this.status,
      required this.orgId,
      required this.donationList});
}
