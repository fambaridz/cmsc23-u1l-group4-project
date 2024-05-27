import 'dart:io';
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
  List<String?> _addresses = [];
  String? _contactNo;
  bool _showErrorMessage = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
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
                _pickupOrDropoff == 'Pickup' ? addressField : Container(),
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
                  title: Text(category,
                      style: const TextStyle(
                        fontSize: 15.0,
                      )),
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
      ]));

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
              "Photo of the item/s to donate",
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
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: _takePhoto,
                      ),
                    )
                  : Image.file(_itemPhoto, fit: BoxFit.cover),
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
      ]));

  Widget get addressField => Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
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
          Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ElevatedButton(
                onPressed: () {
                  _addresses.add(_addressController.text);
                  setState(() {});
                  _addressController.clear();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[200]),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ))
        ]),
        const SizedBox(height: 15),
        const Text(
          "Address/es",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_addresses[index]!));
              },
            )),
      ]));

  Widget get contact => Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Contact number',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              setState(() {
                _contactNo = value;
              });
            },
            validator: (text) {
              if (text == null || text.isEmpty) {
                return "Please enter contact number.";
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        )
      ]));

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
              if (_pickupOrDropoff == 'Pickup') {
                // Donation for pickup
                newDonation = Donation(
                    donorId: user!.uid,
                    category: _selectedCategory,
                    pickupOrDropoff: _pickupOrDropoff,
                    weight: _itemWeight == null
                        ? 'Not applicable.'
                        : '$_itemWeight $_selectedUnit',
                    address: 'address',
                    contactNum: _contactNo,
                    pickUpDateTime: _dateAndTime,
                    // photo: _itemPhoto,
                    status: 1);
              } else {
                // Donation for drop-off
                newDonation = Donation(
                    donorId: user!.uid,
                    category: _selectedCategory,
                    pickupOrDropoff: _pickupOrDropoff,
                    weight: _itemWeight == null
                        ? 'Not applicable.'
                        : '$_itemWeight $_selectedUnit',
                    address: '_addresses',
                    contactNum: _contactNo,
                    dropOffDateTime: _dateAndTime,
                    // photo: _itemPhoto,
                    status: 1);
              }

              GlobalContextService.navigatorKey.currentContext!
                  .read<DonationListProvider>()
                  .addDonation(newDonation, {});

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
                _addresses = [];
                _itemPhoto = File('');
                _showErrorMessage = false;
              });

              // Not sure if it should return to donor home right after submitting
              // if (mounted) Navigator.pushNamed(context, '/donor-home');
            }
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue[200]),
        child: const Text(
          "Submit",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ));
}
