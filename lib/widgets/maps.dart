import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapBox extends StatelessWidget {
  const MapBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(17.6868, 83.2185),
          minZoom: 15.0,
          maxZoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png", // ✅ Updated here
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: const LatLng(17.6868, 83.2185),
                child: const Icon(Icons.location_on, color: Colors.red, size: 50.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
