// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, non_constant_identifier_names, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ChildLocation extends StatefulWidget {
  const ChildLocation({Key? key}) : super(key: key);
  @override
  _ChildLocationState createState() => _ChildLocationState();
}

class _ChildLocationState extends State<ChildLocation>
    with TickerProviderStateMixin {
  MapType _MapType = MapType.normal;

  GoogleMapController? _mapController;
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
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
    // LatLng currentLatLng;
    // if (_currentLocation != null) {
    //   currentLatLng =
    //       LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    // } else {
    //   currentLatLng = const LatLng(0, 0);
    // }
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Admin/$admin/students/$child/location')
          .doc(child)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return const Text('No data available');
        }
        // if (snapshot.hasData) {
        //   var data = snapshot.data!.data() as Map<String, dynamic>;
        //   var latitude = data['latitude'];
        //   var longitude = data['longitude'];
        // }
        var data = snapshot.data!.data() as Map<String, dynamic>;
        var latitude = data['latitude'];
        var longitude = data['longitude'];
        var timestamp = data['timestamp'];
        var datetime =
            DateFormat('dd-MM-yyyy hh:mm:ss a').format(timestamp.toDate());
        // if (latitude != null && longitude != null) {
        //   _mapController!.moveCamera(
        //       CameraUpdate.newLatLng(LatLng(latitude!, longitude!)));
        // }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Child Location'),
            actions: [
              DropdownButton(
                elevation: 0,
                dropdownColor: kPrimaryColor,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 8, bottom: 8),
                //   child:
                Text(
                    'Date & Time: $datetime\nLocation: ($latitude, $longitude)'),
                // ),
                Flexible(
                  child: Stack(
                    children: [
                      GoogleMap(
                          mapType: _getGoogleMapType(_MapType),
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(latitude ?? 0, longitude ?? 0),
                            zoom: 19,
                          ),
                          markers: <Marker>{
                            Marker(
                              markerId: const MarkerId('currentLocation'),
                              position: LatLng(latitude ?? 0, longitude ?? 0),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed),
                            )
                          }),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
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
                                  openMaps(latitude ?? 0, longitude ?? 0);
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
                                  _mapController!.moveCamera(
                                      CameraUpdate.newLatLng(LatLng(
                                          latitude ?? 0, longitude ?? 0)));
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
      },
    );
  }
}
