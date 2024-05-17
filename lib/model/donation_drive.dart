import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/organization.dart';

class DonationDrive {
  String id;
  String name;
  bool status;
  Organization organization;
  List<Donation> donationList;

  DonationDrive({
    required this.id,
    required this.name,
    required this.status,
    required this.organization,
    required this.donationList
  });
}
