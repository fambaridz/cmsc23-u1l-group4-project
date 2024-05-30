import 'dart:convert';

class DonationDrive {
  String? id;
  String name;
  bool status;
  String orgId;
  Map<String, dynamic>? donationList;

  DonationDrive(
      {this.id,
      required this.name,
      required this.status,
      required this.orgId,
      this.donationList});

  get organization => null;

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      orgId: json['orgId'],
      donationList: Map<String, dynamic>.from(json['donationList']),
    );
  }

  static List<DonationDrive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<DonationDrive>((dynamic d) => DonationDrive.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(DonationDrive donationDrive) {
    return {
      'name': donationDrive.name,
      'status': donationDrive.status,
      'orgId': donationDrive.orgId,
      'donationList': donationDrive.donationList,
    };
  }
}
