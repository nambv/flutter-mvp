import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  Geolocator geolocator = Geolocator();
  Position userLocation;

  void updateLocation() {
    getAddress().then((placemark) {
      print(placemark[0].country);
      print(placemark[0].position);
      print(placemark[0].locality);
      print(placemark[0].administrativeArea);
      print(placemark[0].postalCode);
      print(placemark[0].name);
      print(placemark[0].subAdministratieArea);
      print(placemark[0].isoCountryCode);
      print(placemark[0].subLocality);
      print(placemark[0].subThoroughfare);
      print(placemark[0].thoroughfare);
    });
    mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(userLocation.latitude, userLocation.longitude),
            zoom: 14.0),
      ),
    );
  }

  Future<List<Placemark>> getAddress() async {
    return await Geolocator().placemarkFromCoordinates(
        userLocation.latitude, userLocation.longitude);
  }

  @override
  void initState() {
    super.initState();
    _getLocation().then((value) {
      userLocation = value;
      updateLocation();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getLocation().then((value) {
      userLocation = value;
      updateLocation();
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

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
