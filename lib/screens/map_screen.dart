import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('map')),
        body: GoogleMap(
          markers: <Marker>{
            Marker(markerId: const MarkerId('id01'),
            position: const LatLng(13.9166382, 100.5475167),
            infoWindow: InfoWindow(
              title: 'IMM',
              snippet: 'report',
              onTap: () {
                Get.snackbar('Welcome', 'IMM');
              }
            )),
          },
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
              target: LatLng(13.9166382, 100.5475167), zoom: 16),
          onMapCreated: (controller) => _controller.complete(controller),
        ));
  }
}
