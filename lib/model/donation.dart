import 'dart:convert';

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

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
        id: json['id'],
        donor: json['donor'],
        category: json['category'],
        weight: json['weight'],
        address: json['address'],
        contactNo: json['contactNo'],
        pickUpDateTime: json['pickUpDateTime'],
        dropOffDateTime: json['dropOffDateTime'],
        photo: json['photo'],
        status: json['status']);
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'id': donation.id,
      'donor': donation.donor,
      'category': donation.category,
      'weight': donation.weight,
      'address': donation.address,
      'contactNo': donation.contactNo,
      'pickUpDateTime': donation.pickUpDateTime,
      'dropOffDateTime': donation.dropOffDateTime,
      'photo': donation.photo,
      'status': donation.status
    };
  }
}
