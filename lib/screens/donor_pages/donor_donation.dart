import 'dart:io';
import 'package:cmsc23_project/screens/donor_pages/donor_qr_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../GlobalContextService.dart';
import '../../model/donation.dart';
import '../../providers/donation_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';

class DonorDonationPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DonorDonationPage({super.key, required this.userData});

  @override
  State<DonorDonationPage> createState() => _DonorDonationPageState();
}

class _DonorDonationPageState extends State<DonorDonationPage> {

  User? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();

  List<String> donationCategories = [
    'Food',
    'Clothes',
    'Cash',
    'Necessities',
    'Others',
  ];

  List<String> shippingOptions = ['Pickup', 'Drop-off'];

  String? _selectedCategory;
  String _pickupOrDropoff = 'Pickup';
  String? _itemWeight;
  String? _selectedUnit;
  File _itemPhoto = File('');
  String? _dateAndTime;
  String? _address;
  Map<String, String> _addresses = {};
  String? _contactNo;
  bool _showErrorMessage = false;
  String? _selectedAddressKey;
  bool _showExistingAddresses = true;
  Map<String, String> donorAddresses = {};

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    donorAddresses = widget.userData['addresses'].map<String, String>((key, value) => MapEntry(key.toString(), value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor Donation"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: heading),
                donationItemCategory,
                _selectedCategory == 'Others'
                    ? othersItemCategory
                    : Container(),
                pickupOrDropoff,
                _selectedCategory != 'Cash' ? itemWeight : Container(),
                itemPhoto,
                dateTimeField,
                _pickupOrDropoff == 'Pickup' ? addressSection(donorAddresses) : Container(),
                _pickupOrDropoff == 'Pickup' ? contact : Container(),
                submitButton,
                _showErrorMessage
                  ? const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Please fill up all fields.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 228, 33, 19)),
                    ))
                  : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get heading => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Text(
      "Item Donation",
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.lightBlue[400],
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    ),
  );

  Widget get donationItemCategory => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Donation Category",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: donationCategories.map((category) {
            return CheckboxListTile(
              title: Text(
                category,
                style: const TextStyle(
                  fontSize: 15.0,
                )
              ),
              value: _selectedCategory == category,
              onChanged: (bool? value) {
                setState(() {
                  if (value!) {
                    _selectedCategory = category;
                  } else {
                    _selectedCategory = null;
                  }
                });
              },
              activeColor: Colors.lightBlue[400],
            );
          }).toList(),
        ),
      ],
    ),
  );

  Widget get othersItemCategory => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Row(children: [
      Expanded(
        flex: 3,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Item Category',
            border: OutlineInputBorder(),
          ),
          onSaved: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter category of item.";
            }
            return null;
          },
        ),
      )
    ])
  );

  Widget get pickupOrDropoff => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Pickup or Drop-off",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...shippingOptions.map((option) {
          return Row(
            children: [
              Radio(
                value: option,
                groupValue: _pickupOrDropoff,
                onChanged: (String? value) {
                  setState(() {
                    _pickupOrDropoff = value!;
                  });
                },
                activeColor: Colors.lightBlue[400],
              ),
              Text(option),
            ],
          );
        }),
      ],
    ),
  );

  Widget get itemWeight => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Weight',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              setState(() {
                _itemWeight = value;
              });
            },
            validator: (text) {
              if (text == null || text.isEmpty) {
                return "Please enter item weight.";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Unit',
              border: OutlineInputBorder(),
            ),
            value: _selectedUnit,
            items: ['kg', 'lbs']
              .map((unit) => DropdownMenuItem<String>(
                value: unit,
                child: Text(unit),
              ))
              .toList(),
            onChanged: (value) {
              setState(() {
                _selectedUnit = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Cannot be empty.";
              }
              return null;
            },
          ),
        ),
      ],
    ),
  );

  Widget get itemPhoto => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Photo of item/s to donate",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: _itemPhoto.path.isEmpty
            ? Center(
              child: Icon(
                Icons.photo,
                size: 50,
                color: Colors.grey[400],
              ),
            )
            : Image.file(_itemPhoto, fit: BoxFit.cover),
        ),
        if (_itemPhoto.path.isNotEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Photo successfully uploaded.",
                style: TextStyle(color: Colors.green, fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: _takePhoto,
            child: const Text(
              'Take Photo',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[200],
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: _takePhotoGallery,
            child: const Text(
              'Choose from Gallery',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[200],
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _itemPhoto = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhotoGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _itemPhoto = File(pickedFile.path);
      });
    }
  }

  Widget get dateTimeField => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Row(children: [
      Expanded(
        flex: 3,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Date and Time',
            hintText: 'MM/DD/YYYY 24:00',
            border: OutlineInputBorder(),
          ),
          onSaved: (value) {
            setState(() {
              _dateAndTime = value;
            });
          },
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter date and time.";
            }
            return null;
          },
          keyboardType: TextInputType.datetime,
        ),
      )
    ])
  );

  Widget addressSection(Map<String, String> donorAddresses) => Padding(
    padding: const EdgeInsets.only(top:10, bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Address",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showExistingAddresses = true;
                  });
                },
                child: const Text(
                  'Choose from existing addresses',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[200],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showExistingAddresses = false;
                    
                  });
                },
                child: const Text(
                  'Add new address',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[200],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
        _showExistingAddresses
          ? existingAddressesDropdown(donorAddresses)
          : addNewAddressField,
      ],
    ),
  );

  Widget existingAddressesDropdown(Map<String, String> donorAddresses) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Existing Addresses",
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: _selectedAddressKey,
          items: donorAddresses.keys
            .map((key) => DropdownMenuItem<String>(
              value: key,
              child: Text(key),
            ))
            .toList(),
          onChanged: (value) {
            setState(() {
              _address = donorAddresses[value];
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select an address.";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        const Text(
          "Selected Address",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Text(_address ?? 'No address selected.'),
        ),
      ],
    ),
  );

  Widget get addNewAddressField => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 5.0),
        child: TextFormField(
          controller: _labelController,
          decoration: const InputDecoration(
            labelText: 'Label',
            hintText: 'Home, Office, School',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (_addresses.isEmpty) {
              return "Please enter a label for your address.";
            } else {
              return null;
            }
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
            labelText: 'Address',
            hintText: 'Street, Barangay, City, Province',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (_addresses.isEmpty) {
              return "Please enter an address.";
            } else {
              return null;
            }
          },
        ),
      ),
      Center(
        child: ElevatedButton(
          onPressed: () {
            // Check if both label and address are filled up
            if (_labelController.text.isNotEmpty && _addressController.text.isNotEmpty) {
              _addresses[_labelController.text] = _addressController.text;
              _address = _addressController.text;
              // Update donorAddresses with new address
              _addresses.forEach((key, value) {
                donorAddresses[key] = value;
              });

              setState(() {});
              _labelController.clear();
              _addressController.clear();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.lightBlue[400],
                  content: Text(
                    'Please fill up both fields.',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue[200]),
          child: const Text(
            'Add Address',
            style: TextStyle(
              fontSize: 15.0, 
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ),
      const SizedBox(height: 15),
      const Text(
        "Address/es",
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _addresses.length,
          itemBuilder: (context, index) {
            var label = _addresses.keys.toList();
            var address = _addresses.values.toList();
            return Padding(
              padding: const EdgeInsets.all(7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _addresses.remove(label[index]);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${label[index]}: ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "${address[index]}",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ),
    ])
  );

  Widget get contact => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Row(children: [
      Expanded(
        flex: 3,
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Contact number',
            border: OutlineInputBorder(),
            hintText: '09XXXXXXXXX',
          ),
          onSaved: (value) {
            setState(() {
              _contactNo = value;
            });
          },
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter contact number.";
            } else {
              if (text.length != 11) {
                return "Please enter a valid contact number.";
              }
            }
            return null;
          },
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      )
    ])
  );

  Widget get submitButton => Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      onPressed: () async {
        // Manual validation of selected category
        if (_selectedCategory == null) {
          setState(() {
            _formKey.currentState!.validate();
            _showErrorMessage = true;
          });
        } else {
          if (_formKey.currentState!.validate()) {

            _formKey.currentState?.save();

            Donation newDonation;

            if (_pickupOrDropoff == 'Pickup' && _itemPhoto.path.isNotEmpty) {
              
              // Donation for pickup
              newDonation = Donation(
                donorId: user!.uid,
                category: _selectedCategory,
                pickupOrDropoff: _pickupOrDropoff,
                weight: _itemWeight == null
                  ? 'Not applicable.'
                  : '$_itemWeight $_selectedUnit',
                address: _address!,
                contactNum: _contactNo,
                pickUpDateTime: _dateAndTime,
                itemPhotoUrl: "",
                status: 1
              );

              String? message = await GlobalContextService.navigatorKey.currentContext!
                .read<DonationListProvider>()
                .addDonationWithFile(newDonation, donorAddresses, _itemPhoto);
              
              if (!message!.startsWith("Error in")) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.lightBlue[400],
                    content: const Text(
                      'Donation is now submitted. Please wait for confirmation from organization.',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );

                // Reset form and values
                _formKey.currentState?.reset();
                setState(() {
                  _selectedCategory = null;
                  _pickupOrDropoff = 'Pickup';
                  _itemWeight = null;
                  _selectedUnit = null;
                  _address = null;
                  _addresses = {};
                  _itemPhoto = File('');
                  _showErrorMessage = false;
                });

                Navigator.pushNamed(context, '/donor-home');

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: const Text(
                      'Failed to submit donation. Please try again.',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );
              }

            } else if (_pickupOrDropoff == 'Pickup' && _itemPhoto.path.isEmpty) {

              // Donation for pickup
              newDonation = Donation(
                donorId: user!.uid,
                category: _selectedCategory,
                pickupOrDropoff: _pickupOrDropoff,
                weight: _itemWeight == null
                  ? 'Not applicable.'
                  : '$_itemWeight $_selectedUnit',
                address: _address!,
                contactNum: _contactNo,
                pickUpDateTime: _dateAndTime,
                itemPhotoUrl: "No photo uploaded.",
                status: 1
              );

              String? message = await GlobalContextService.navigatorKey.currentContext!
                .read<DonationListProvider>()
                .addDonation(newDonation, donorAddresses);
              
              if (!message!.startsWith("Error in")) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.lightBlue[400],
                    content: const Text(
                      'Donation is now submitted. Please wait for confirmation from organization.',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );

                // Reset form and values
                _formKey.currentState?.reset();
                setState(() {
                  _selectedCategory = null;
                  _pickupOrDropoff = 'Pickup';
                  _itemWeight = null;
                  _selectedUnit = null;
                  _address = null;
                  _addresses = {};
                  _itemPhoto = File('');
                  _showErrorMessage = false;
                });

                Navigator.pushNamed(context, '/donor-home');

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: const Text(
                      'Failed to submit donation. Please try again.',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );
              }

            } else if (_pickupOrDropoff == 'Drop-off' && _itemPhoto.path.isNotEmpty) {

              // Donation for drop-off
              newDonation = Donation(
                donorId: user!.uid,
                category: _selectedCategory,
                pickupOrDropoff: _pickupOrDropoff,
                weight: _itemWeight == null
                    ? 'Not applicable.'
                    : '$_itemWeight $_selectedUnit',
                address: 'Not applicable.',
                contactNum: 'Not applicable.',
                dropOffDateTime: _dateAndTime,
                itemPhotoUrl: "",
                status: 1
              );

              String? message = await GlobalContextService.navigatorKey.currentContext!
                .read<DonationListProvider>()
                .addDonationWithFile(newDonation, donorAddresses, _itemPhoto);
              
              if (!message!.startsWith("Error in")) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.lightBlue[400],
                    content: const Text(
                      'Donation is now submitted. Please wait for confirmation from organization.',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );

                // Reset form and values
                _formKey.currentState?.reset();
                setState(() {
                  _selectedCategory = null;
                  _pickupOrDropoff = 'Pickup';
                  _itemWeight = null;
                  _selectedUnit = null;
                  _address = null;
                  _addresses = {};
                  _itemPhoto = File('');
                  _showErrorMessage = false;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return DonorQRPage(message);
                    }),
                  ),
                );

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: const Text(
                      'Failed to submit donation. Please try again.',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );
              }
              
            } else {

              // Donation for drop-off
              newDonation = Donation(
                donorId: user!.uid,
                category: _selectedCategory,
                pickupOrDropoff: _pickupOrDropoff,
                weight: _itemWeight == null
                    ? 'Not applicable.'
                    : '$_itemWeight $_selectedUnit',
                address: 'Not applicable.',
                contactNum: 'Not applicable.',
                dropOffDateTime: _dateAndTime,
                itemPhotoUrl: "No photo uploaded.",
                status: 1
              );

              String? message = await GlobalContextService.navigatorKey.currentContext!
                .read<DonationListProvider>()
                .addDonation(newDonation, donorAddresses);
              
              if (!message!.startsWith("Error in")) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.lightBlue[400],
                    content: const Text(
                      'Donation is now submitted. Please wait for confirmation from organization.',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );

                // Reset form and values
                _formKey.currentState?.reset();
                setState(() {
                  _selectedCategory = null;
                  _pickupOrDropoff = 'Pickup';
                  _itemWeight = null;
                  _selectedUnit = null;
                  _address = null;
                  _addresses = {};
                  _itemPhoto = File('');
                  _showErrorMessage = false;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return DonorQRPage(message);
                    }),
                  ),
                );
                
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: const Text(
                      'Failed to submit donation. Please try again.',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                );
              }
            }
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue[200],
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),      
      child: const Text(
        'Donate',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    )
  );
}