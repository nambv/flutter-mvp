import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final Location destination;

  MapView(this.destination);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  Geolocator geolocator = Geolocator();
  Position userLocation;

  @override
  void initState() {
    super.initState();
    _getLocation().then((value) {
      userLocation = value;
    });
  }

  Future _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController?.addMarker(MarkerOptions(
        position: LatLng(double.parse(widget.destination.coordinates.latitude),
            double.parse(widget.destination.coordinates.longitude))));

    _getLocation().then((value) {
      userLocation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> mainView = _createViews();
    if (Platform.isAndroid) {
      mainView.add(createMyLocationButton());
    }

    return MaterialApp(
      home: Scaffold(
        body: Stack(children: mainView),
      ),
    );
  }

  List<Widget> _createViews() {
    return <Widget>[
      GoogleMap(
        onMapCreated: _onMapCreated,
        options: GoogleMapOptions(
          cameraPosition: CameraPosition(
            target: LatLng(
                double.parse(widget.destination.coordinates.latitude),
                double.parse(widget.destination.coordinates.longitude)),
            zoom: 14.0,
          ),
          myLocationEnabled: true,
        ),
      ),
    ];
  }

  Widget createMyLocationButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          child: Icon(Icons.my_location),
          onPressed: () {
            _moveToCurrentLocation();
          },
        ),
      ),
    );
  }

  void _moveToCurrentLocation() {
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
