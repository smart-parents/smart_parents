// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:geocoding/geocoding.dart' as geo;

class LiveLocationPage extends StatefulWidget {
  const LiveLocationPage({Key? key}) : super(key: key);

  @override
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage>
    with TickerProviderStateMixin {
  LocationData? _currentLocation;
  late final MapController _mapController;

  // bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';
  // String? _locationName;

  int interActiveFlags = InteractiveFlag.all;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
    // _getLocationName();
  }

  // Future<void> _getLocationName() async {
  //   try {
  //     List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
  //         _currentLocation!.latitude!, _currentLocation!.longitude!);
  //     if (placemarks.isNotEmpty) {
  //       setState(() {
  //         _locationName = placemarks[0].name;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   Timer(const Duration(seconds: 1), () {
  //     _getLocationName();
  //   });
  // }

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
          _locationService.onLocationChanged
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;
                // if (_liveUpdate) {
                _mapController.move(
                    LatLng(_currentLocation!.latitude!,
                        _currentLocation!.longitude!),
                    _mapController.zoom);
                // _animatedMapMove(
                //     LatLng(_currentLocation!.latitude!,
                //         _currentLocation!.longitude!),
                //     _mapController.zoom);
                // }
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
    _animatedMapMove(
        LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        _mapController.zoom);
  }

  void openMaps(double latitude, double longitude) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    final markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: currentLatLng,
        builder: (context) => const Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 40,
          key: ObjectKey(Colors.blue),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Child Location')),
      // drawer: buildDrawer(context, LiveLocationPage.route),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: _serviceError!.isEmpty
                  ? Text('This is a map that is showing '
                      '(${currentLatLng.latitude}, ${currentLatLng.longitude})'
                      // '\nLocation Name: $_locationName'
                      )
                  : Text(
                      'Error occured while acquiring location. Error Message : '
                      '$_serviceError'),
            ),
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center:
                      LatLng(currentLatLng.latitude, currentLatLng.longitude),
                  // zoom: 1,
                  // maxZoom: 100,
                  interactiveFlags: interActiveFlags,
                ),
                children: [
                  // TileLayer(
                  //   urlTemplate:
                  //       'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  //   userAgentPackageName: 'com.example.smart_parents',
                  // ),
                  TileLayer(
                    urlTemplate:
                        "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?api_key={api_key}",
                    additionalOptions: const {
                      "api_key": "b362d545-8e66-4a20-b5fc-8083884adda5",
                    },
                    userAgentPackageName: 'com.example.smart_parents',
                    // maxNativeZoom: 20,
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //   Stack(
          // children: [
          // Positioned(
          //   bottom: 80.0,
          //   right: 20.0,
          //   child:
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              setState(() {
                initLocationService();
                openMaps(
                    _currentLocation!.latitude!, _currentLocation!.longitude!);
              });
            },
            tooltip: 'Google Map',
            child: const Icon(Icons.location_on),
          ),
          // ),
          const SizedBox(height: 10),
          // Positioned(
          //   bottom: 20.0,
          //   right: 20.0,
          //   child:
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () {
              setState(() {
                // _mapController.move(
                //     LatLng(_currentLocation!.latitude!,
                //         _currentLocation!.longitude!),
                //     _mapController.zoom);
                initLocationService();
                _animatedMapMove(
                    LatLng(_currentLocation!.latitude!,
                        _currentLocation!.longitude!),
                    _mapController.zoom);
                // shareLiveLocation();
                // _liveUpdate = !_liveUpdate;

                // if (_liveUpdate) {
                //   interActiveFlags = InteractiveFlag.rotate |
                //       InteractiveFlag.pinchZoom |
                //       InteractiveFlag.doubleTapZoom;

                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: Text(
                //         'In live update mode only zoom and rotation are enable'),
                //   ));
                // } else {
                //   interActiveFlags = InteractiveFlag.all;
                // }
              });
            },
            tooltip: 'Live Location',
            child:
                // _liveUpdate
                //     ? const Icon(Icons.location_on)
                //     : const Icon(Icons.location_off),
                const Icon(Icons.my_location),
          ),
          // ),
        ],
      ),
    );
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
