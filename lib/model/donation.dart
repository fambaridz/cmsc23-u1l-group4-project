import 'dart:convert';

class Donation {
  String? id;
  String donorId;
  String? category;
  String pickupOrDropoff;
  String weight;
  String address;
  String? contactNum;
  String? pickUpDateTime;
  String? dropOffDateTime;
  String? itemPhotoUrl;
  int status;

  Donation(
    { 
      this.id,
      required this.donorId,
      required this.category,
      required this.pickupOrDropoff,
      required this.weight,
      required this.address,
      required this.contactNum,
      this.pickUpDateTime,
      this.dropOffDateTime,
      this.itemPhotoUrl,
      required this.status
    }
  );

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
        id: json['id'],
        donorId: json['donorId'],
        category: json['category'],
        pickupOrDropoff: json['pickupOrDropoff'],
        weight: json['weight'],
        address: json['address'],
        contactNum: json['contactNum'],
        pickUpDateTime: json['pickUpDateTime'],
        dropOffDateTime: json['dropOffDateTime'],
        itemPhotoUrl: json['itemPhotoUrl'],
        status: json['status']);
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'donorId': donation.donorId,
      'category': donation.category,
      'pickupOrDropoff': donation.pickupOrDropoff,
      'weight': donation.weight,
      'address': donation.address,
      'contactNum': donation.contactNum,
      'pickUpDateTime': donation.pickUpDateTime,
      'dropOffDateTime': donation.dropOffDateTime,
      'itemPhotoUrl': donation.itemPhotoUrl,
      'status': donation.status
    };
  }
}
