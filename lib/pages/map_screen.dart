import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isSatelliteView = false; // Track whether the map is in satellite view or normal view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(widget.latitude, widget.longitude), // Center map on passed coordinates
          initialZoom: 15.0, // Initial zoom level
        ),
        children: [
          TileLayer(
            urlTemplate: isSatelliteView
                ? 'https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}' // Satellite map view
                : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // Normal map view
            subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(widget.latitude, widget.longitude),
                child:  Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        children: [
          SizedBox(height: 200,),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isSatelliteView = !isSatelliteView; // Toggle the map view
              });
            },
            child: const Icon(Icons.map),
            tooltip: 'Switch Map View',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop, // Position on right-center
    );
  }
}
