class Donation {
  String id;
  String donor;
  String category;
  double weight;
  String address;
  String contactNo;
  String pickUpDateTime;
  String dropOffDateTime;
  String? photo;
  int status;

  Donation(
      {required this.id,
      required this.donor,
      required this.category,
      required this.weight,
      required this.address,
      required this.contactNo,
      required this.pickUpDateTime,
      required this.dropOffDateTime,
      this.photo,
      required this.status});
}
