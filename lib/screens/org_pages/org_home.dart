import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/constants/donation_status_map.dart';
import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/screens/org_pages/org_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({super.key});

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {
  late Map<String, dynamic> userData;
  User? user;
  // Stream<QuerySnapshot>? donationList;
  // final List<Donation> donationList = [
  //   Donation(
  //       id: "1",
  //       donorId: "Juan Dela Cruz",
  //       category: "Clothes",
  //       weight: '5 lbs',
  //       address: "1234 Donations St.",
  //       contactNum: "09123456789",
  //       pickUpDateTime: "2022-12-31 23:59:59",
  //       dropOffDateTime: "2023-01-01 00:00:00",
  //       itemPhotoUrl: "photo.jpg",
  //       status: 1, pickupOrDropoff: ''),
  //   Donation(
  //       id: "2",
  //       donorId: "Pedro Penduko",
  //       category: "Books",
  //       weight: '10 kg',
  //       address: "5678 Donations St.",
  //       contactNum: "09876543210",
  //       pickUpDateTime: "2022-12-31 23:59:59",
  //       dropOffDateTime: "2023-01-01 00:00:00",
  //       itemPhotoUrl: "photo.jpg",
  //       status: 2, pickupOrDropoff: ''),
  //   Donation(
  //       id: "3",
  //       donorId: "Maria Makiling",
  //       category: "Food",
  //       weight: '15 kg',
  //       address: "91011 Donations St.",
  //       contactNum: "09123456789",
  //       pickUpDateTime: "2022-12-31 23:59:59",
  //       dropOffDateTime: "2023-01-01 00:00:00",
  //       itemPhotoUrl: "photo.jpg",
  //       status: 3, pickupOrDropoff: ''),
  //   Donation(
  //       id: "4",
  //       donorId: "Juan Tamad",
  //       category: "Toys",
  //       weight: '20 lbs',
  //       address: "121314 Donations St.",
  //       contactNum: "09876543210",
  //       pickUpDateTime: "2022-12-31 23:59:59",
  //       dropOffDateTime: "2023-01-01 00:00:00",
  //       itemPhotoUrl: "photo.jpg",
  //       status: 4, pickupOrDropoff: ''),
  //   Donation(
  //       id: "5",
  //       donorId: "Pedro Penduko",
  //       category: "Clothes",
  //       weight: '25 lbs',
  //       address: "151617 Donations St.",
  //       contactNum: "09123456789",
  //       pickUpDateTime: "2022-12-31 23:59:59",
  //       dropOffDateTime: "2023-01-01 00:00:00",
  //       itemPhotoUrl: "photo.jpg",
  //       status: 5, pickupOrDropoff: ''),
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    // donationList = context.read<DonationListProvider>().donation;
    Future<List<Map<String, dynamic>?>> donationList = context
        .read<DonationListProvider>()
        .getUnsortedDonationByOrgId(user!.uid);
    if (user != null) {
      context.read<UserAuthProvider>().getUserData(user!.uid).then((value) {
        setState(() {
          userData = value!;
        });
      });
    }
    ;

    return Scaffold(
      drawer: OrganizationDrawer(userData: userData),
      appBar: AppBar(
        title: Text("Unsorted Donations"),
      ),
      body: Center(
            child: FutureBuilder(
                future: donationList,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Unsorted Donations Found"),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      Donation donation = Donation.fromJson(
                          snapshot.data?[index]
                              as Map<String, dynamic>);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, "/org-home/donation/details",
                              arguments: {"details": donation});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          margin: EdgeInsets.all(3),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(20),
                            leading: FractionallySizedBox(
                              heightFactor: 1,
                              widthFactor: 0.32,
                              child: TextButton(
                                  onPressed: () {
                                    donation.status = donation.status == 5
                                        ? 1
                                        : donation.status + 1;
                                    setState(() {});
                                  },
                                  child: Text(
                                    statusMap[donation.status]!["text"]
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        statusMap[donation.status]!["color"]
                                            as Color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                  )),
                            ),
                            title: Text(
                              donation.donorId,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }))
    );
  }
}

Text donorDetails(String donorId) {
  return Text(
    donorId,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}



// stream
// Center(
//             child: StreamBuilder(
//                 stream: donationList,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Center(
//                       child: Text("Error: ${snapshot.error}"),
//                     );
//                   } else if (snapshot.connectionState ==
//                       ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (!snapshot.hasData) {
//                     return Center(
//                       child: Text("No Unsorted Donations Found"),
//                     );
//                   }
//                   return ListView.builder(
//                     padding: const EdgeInsets.all(10),
//                     itemCount: snapshot.data?.docs.length,
//                     itemBuilder: (context, index) {
//                       Donation donation = Donation.fromJson(
//                           snapshot.data?.docs[index].data()
//                               as Map<String, dynamic>);
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(
//                               context, "/org-home/donation/details",
//                               arguments: {"details": donation});
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey[100],
//                           ),
//                           margin: EdgeInsets.all(3),
//                           child: ListTile(
//                             contentPadding: EdgeInsets.all(20),
//                             leading: FractionallySizedBox(
//                               heightFactor: 1,
//                               widthFactor: 0.32,
//                               child: TextButton(
//                                   onPressed: () {
//                                     donation.status = donation.status == 5
//                                         ? 1
//                                         : donation.status + 1;
//                                     setState(() {});
//                                   },
//                                   child: Text(
//                                     statusMap[donation.status]!["text"]
//                                         .toString(),
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   style: TextButton.styleFrom(
//                                     backgroundColor:
//                                         statusMap[donation.status]!["color"]
//                                             as Color,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(11),
//                                     ),
//                                   )),
//                             ),
//                             title: Text(
//                               donation.donorId,
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }))

//list
// Center(
//         child: donationList.isEmpty
//             ? const Text("No unsorted donations.")
//             : ListView(
//                 padding: const EdgeInsets.all(10),
//                 children: donationList
//                     .map((donation) => GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context, "/org-home/donation/details",
//                                 arguments: {"details": donation});
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.grey[100],
//                             ),
//                             margin: EdgeInsets.all(3),
//                             child: ListTile(
//                               contentPadding: EdgeInsets.all(20),
//                               leading: FractionallySizedBox(
//                                 heightFactor: 1,
//                                 widthFactor: 0.32,
//                                 child: TextButton(
//                                     onPressed: () {
//                                       donation.status = donation.status == 5
//                                           ? 1
//                                           : donation.status + 1;
//                                       setState(() {});
//                                     },
//                                     child: Text(
//                                       statusMap[donation.status]!["text"]
//                                           .toString(),
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         // shadows: [
//                                         //   Shadow(
//                                         //     color: Colors.grey,
//                                         //     offset: Offset(0.8, 0.8),
//                                         //   ),
//                                         // ],
//                                       ),
//                                     ),
//                                     style: TextButton.styleFrom(
//                                       backgroundColor:
//                                           statusMap[donation.status]!["color"]
//                                               as Color,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(11),
//                                       ),
//                                     )),
//                               ),
//                               title: Text(
//                                 donation.donorId,
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ))
//                     .toList(),
//               ),
//       ),