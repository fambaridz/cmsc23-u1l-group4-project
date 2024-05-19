import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../GlobalContextService.dart';
import '../model/donation.dart';
import '../providers/donation_provider.dart';

class DonorDonationPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DonorDonationPage({super.key, required this.userData});

  @override
  State<DonorDonationPage> createState() => _DonorDonationPageState();
}

class _DonorDonationPageState extends State<DonorDonationPage> {
  final _formKey = GlobalKey<FormState>();

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
  bool _showErrorMessage = false;

  @override
  Widget build(BuildContext context) {
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
                pickupOrDropoff,
                _selectedCategory != 'Cash' ? itemWeight : Container(),
                itemPhoto,
                submitButton,
                _showErrorMessage
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Please fill up all fields",
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

  Widget get submitButton => ElevatedButton(
        onPressed: () async {
          // Manual validation of selected category and item photo
          if (_selectedCategory == null || _itemPhoto.path.isEmpty) {
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
                    id: '1',
                    donor: widget.userData["name"],
                    category: _selectedCategory,
                    weight: _itemWeight == null
                        ? 'Not applicable.'
                        : '$_itemWeight $_selectedUnit',
                    address: 'address',
                    contactNo: 'contactNo',
                    pickUpDateTime: 'pickUpDateTime',
                    // photo: _itemPhoto,
                    status: 0);
              } else {
                // Donation for drop-off
                newDonation = Donation(
                    id: '1',
                    donor: widget.userData["name"],
                    category: _selectedCategory,
                    weight: _itemWeight == null
                        ? 'Not applicable.'
                        : '$_itemWeight $_selectedUnit',
                    address: 'address',
                    contactNo: 'contactNo',
                    dropOffDateTime: 'dropOffDateTime',
                    // photo: _itemPhoto,
                    status: 0);
              }

              GlobalContextService.navigatorKey.currentContext!
                  .read<DonationListProvider>()
                  .addDonation(newDonation);

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
      );
}
