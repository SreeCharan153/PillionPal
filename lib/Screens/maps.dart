import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class map_box extends StatelessWidget {
  const map_box({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Center(
        child: FlutterMap(
            options: MapOptions(
            initialCenter: LatLng(17.6868, 83.2185),
            minZoom: 15.0,
            maxZoom: 18.0,
            ),
            children: [
              TileLayer(
            urlTemplate:
              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
      markers: [
        Marker(
          width: 80.0,
          height: 80.0,
            point: LatLng(17.6868, 83.2185),
            child: Icon(Icons.location_on, color: Colors.red, size: 50.0),
           ),
      ],
    ),
              
            
            ],
          ),
        ),
      );
    
  }
}