import 'dart:convert';

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
  bool isVerified = false;
  String? photoUrl;

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
    required this.isVerified,
    required this.photoUrl,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      userType: json['userType'],
      name: json['name'],
      aboutUs: json['aboutUs'],
      username: json['username'],
      email: json['email'],
      addresses: Map<String, String>.from(json['addresses']),
      contactNum: json['contactNum'],
      status: json['status'],
      isVerified: json['isVerified'],
      photoUrl: json['photoUrl'],
    );
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Organization>((dynamic d) => Organization.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Organization organization) {
    return {
      'id': organization.id,
      'userType': organization.userType,
      'name': organization.name,
      'aboutUs': organization.aboutUs,
      'username': organization.username,
      'email': organization.email,
      'addresses': organization.addresses,
      'contactNum': organization.contactNum,
      'status': organization.status,
      'isVerified': organization.isVerified,
      'photoUrl': organization.photoUrl,
    };
  }

}
