import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapBox extends StatefulWidget {
  const MapBox({super.key});

  @override
  _MapBoxState createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  // 🔹 Track User's Movement
  void _startLocationUpdates() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // Updates location every 5 meters
      ),
    ).listen((Position position) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      // Move the map to the new location
      _mapController.move(_currentLocation!, _mapController.zoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Location Tracking')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _currentLocation == null
              ? const Center(child: Text("Unable to fetch location"))
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentLocation!,
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: _currentLocation!,
                          child: const Icon(
                            Icons.location_pin,
                            color: Color.fromRGBO(0, 137, 85, 1),
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
