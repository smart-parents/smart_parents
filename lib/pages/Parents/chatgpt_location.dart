// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveLocationMap extends StatefulWidget {
  const LiveLocationMap({Key? key}) : super(key: key);
  @override
  _LiveLocationMapState createState() => _LiveLocationMapState();
}

class _LiveLocationMapState extends State<LiveLocationMap>
    with TickerProviderStateMixin {
  LocationData? _currentLocation;
  bool _permission = false;
  String? _serviceError = '';
  Marker? _currentLocationMarker;
  final Location _locationService = Location();
  MapType _MapType = MapType.normal;
  @override
  void initState() {
    super.initState();
    initLocationService();
  }

  GoogleMapController? _mapController;
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );
    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;
    try {
      serviceEnabled = await _locationService.serviceEnabled();
      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;
        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _currentLocationMarker = Marker(
            markerId: const MarkerId('currentLocation'),
            position: LatLng(
                _currentLocation!.latitude!, _currentLocation!.longitude!),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          );
          _locationService.onLocationChanged
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;
                _mapController!.moveCamera(CameraUpdate.newLatLng(LatLng(
                    _currentLocation!.latitude!,
                    _currentLocation!.longitude!)));
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  static final List<DropdownMenuItem<MapType>> _mapTypeDropdownItems = [
    const DropdownMenuItem(
      value: MapType.normal,
      child: Text("Normal"),
    ),
    const DropdownMenuItem(
      value: MapType.satellite,
      child: Text("Satellite"),
    ),
    const DropdownMenuItem(
      value: MapType.terrain,
      child: Text("Terrain"),
    ),
    const DropdownMenuItem(
      value: MapType.hybrid,
      child: Text("Hybrid"),
    ),
  ];

  MapType _getGoogleMapType(MapType mapType) {
    switch (mapType) {
      case MapType.normal:
        return MapType.normal;
      case MapType.satellite:
        return MapType.satellite;
      case MapType.terrain:
        return MapType.terrain;
      case MapType.hybrid:
        return MapType.hybrid;
      default:
        throw ArgumentError("Invalid map type: $mapType");
    }
  }

  void openMaps(double latitude, double longitude) async {
    String googleMapsUrl =
        // 'https://www.google.com/maps?q=$latitude,$longitude&z=17&t=k&output=embed';
        'https://www.google.com/maps?q=$latitude,$longitude&z=17&t=k&output=embed&markers=$latitude,$longitude';
    // 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = const LatLng(0, 0);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Location'),
        actions: [
          DropdownButton(
            elevation: 0,
            dropdownColor: kPrimaryColor,
            // focusColor: kPrimaryColor,
            //  Colors.grey[800],
            value: _MapType,
            style: const TextStyle(
              color: Colors.white,
            ),
            items: _mapTypeDropdownItems,
            icon: const ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: Icon(Icons.arrow_drop_down),
            ),
            onChanged: (MapType? newValue) {
              setState(() {
                _MapType = newValue!;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: _serviceError!.isEmpty
                  ? Text('This is a map that is showing '
                      '(${currentLatLng.latitude}, ${currentLatLng.longitude})')
                  : Text(
                      'Error occured while acquiring location. Error Message : '
                      '$_serviceError'),
            ),
            Flexible(
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: _getGoogleMapType(_MapType),
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLatLng.latitude, currentLatLng.longitude),
                      zoom: 15,
                    ),
                    markers: _currentLocationMarker != null
                        ? {_currentLocationMarker!}
                        : {},
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.grey[600],
                          heroTag: 'button1',
                          onPressed: () {
                            setState(() {
                              initLocationService();
                              openMaps(_currentLocation!.latitude!,
                                  _currentLocation!.longitude!);
                            });
                          },
                          tooltip: 'Google Map',
                          child: const Icon(
                            Icons.location_on,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.grey[600],
                          heroTag: 'button2',
                          onPressed: () {
                            setState(() {
                              initLocationService();
                              _mapController!.moveCamera(CameraUpdate.newLatLng(
                                  LatLng(_currentLocation!.latitude!,
                                      _currentLocation!.longitude!)));
                            });
                          },
                          tooltip: 'Live Location',
                          child: const Icon(
                            Icons.my_location,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
