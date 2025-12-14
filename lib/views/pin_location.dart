import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PinLocationView extends StatefulWidget {
  const PinLocationView({super.key});

  @override
  State<PinLocationView> createState() => _PinLocationViewState();
}

class _PinLocationViewState extends State<PinLocationView> {
  Set<Marker> markers = {};

  final position = LatLng(31.0414531, 31.34164);

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showMsg("برجاء تفعيل خدمة الوصول الي الموقع");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("build Location")),
      body: GoogleMap(
        markers: markers,
        onTap: (argument) {
          markers.add(
            Marker(
              markerId: MarkerId(
                "loc${argument.latitude},${argument.longitude}",
              ),
              position: argument,
            ),
          );
          setState(() {});
        },

        initialCameraPosition: CameraPosition(target: position, zoom: 10),
      ),
    );
  }
}
