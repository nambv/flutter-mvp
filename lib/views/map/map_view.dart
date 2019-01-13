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
  Map<String, double> userLocation;

  void moveMapToLocation(Map<String, double> value) {
    mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(value["latitude"], value["longitude"]), zoom: 14.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    location.onLocationChanged().listen((value) async {
//      moveMapToLocation(value);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getLocation().then((value) {
      moveMapToLocation(value);
    });
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
