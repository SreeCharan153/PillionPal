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
  LatLng? _currentLocation;
  bool _isLoading = true; // Loading state for UI feedback

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  // 🔹 Fetch User Location
  Future<void> _fetchUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      debugPrint("Location permission denied.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Location')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading state
          : _currentLocation == null
              ? const Center(child: Text("Unable to fetch location"))
              : FlutterMap(
                  options: MapOptions(
                    initialCenter: _currentLocation!, // 🌍 Center map on user's location
                    minZoom: 10.0,
                    maxZoom: 18.0,
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
                          child: const Icon(Icons.location_pin, color: Color.fromRGBO(0, 137, 85, 1), size: 40.0),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
