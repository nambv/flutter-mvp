import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  var location = new Location();
  Marker marker;
  Map<String, double> userLocation;

  void updateLocation(Map<String, double> value) {}

  @override
  void initState() {
    super.initState();
    location.onLocationChanged().listen((location) async {
      if (marker != null) {
        mapController.removeMarker(marker);
      }

      mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(location["latitude"], location["longitude"]),
              zoom: 14.0),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            cameraPosition: CameraPosition(
                target: LatLng(37.4219999, -122.0862462), zoom: 14.0),
            myLocationEnabled: true,
          ),
        ),
      ),
    );
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
