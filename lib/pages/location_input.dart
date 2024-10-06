import 'package:flutter/material.dart';
import 'map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? selectedValue = "city";
  bool changeOption = true;
  double lat = 12.9715987;
  double long = 77.5945627;
  TextEditingController cityController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // To track form validation

  List<DropdownMenuItem<String>> list = [
    DropdownMenuItem(
      value: 'city',
      child: const Text("Search by Address or City"),
    ),
    DropdownMenuItem(
      value: 'co-ordinates',
      child: const Text("Search by Co-ordinates"),
    ),
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey, // Attach form key to the form
          child: Column(
            children: [
              customDropdown(),
              const SizedBox(height: 16),
              customInputBox(),
              const SizedBox(height: 16),
              submitBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget customDropdown() {
    return Container(
      width: double.infinity, // Full width
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.blue, // Blue background color
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        items: list,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        dropdownColor: Colors.blue[200],
        iconEnabledColor: Colors.white, // White icon
        style: const TextStyle(color: Colors.white), // White text
        isExpanded: true, // Full width
      ),
    );
  }

  Widget customInputBox() {
    return selectedValue == "co-ordinates"
        ? Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextFormField(
              controller: latitudeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Latitude',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter latitude';
                }
                final latitude = double.tryParse(value);
                if (latitude == null || latitude < -90 || latitude > 90) {
                  return 'Please enter a valid latitude (-90 to 90)';
                }
                return null;
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextFormField(
              controller: longitudeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Longitude',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter longitude';
                }
                final longitude = double.tryParse(value);
                if (longitude == null || longitude < -180 || longitude > 180) {
                  return 'Please enter a valid longitude (-180 to 180)';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    )
        : SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: cityController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Address or City',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a city or address';
          }
          return null;
        },
      ),
    );
  }

  Widget submitBtn(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full width button
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (selectedValue == 'co-ordinates') {
              lat = double.parse(latitudeController.text);
              long = double.parse(longitudeController.text);
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(
                  latitude: lat,
                  longitude: long,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Blue background color
          padding: const EdgeInsets.symmetric(vertical: 16.0), // Button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.white, // White text color
            fontSize: 16.0, // Font size
          ),
        ),
      ),
    );
  }
}
