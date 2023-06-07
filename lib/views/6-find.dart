import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wathaequi/models/Nearby.dart';
import 'package:wathaequi/view_models/find_vm.dart';
import 'package:wathaequi/views/res/colors.dart';

import '7-nearbyList.dart';

class Find extends StatefulWidget {
  const Find({Key? key}) : super(key: key);

  @override
  State<Find> createState() => _FindState();
}

class _FindState extends State<Find> {
  FindViewModel _model = FindViewModel();
  NearbyPlacesResponse? response;
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(36.773421, 3.058348), zoom: 14);
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              mini: true,
              backgroundColor: darkColor,
              heroTag: "f1",
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Determining your position...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
                Position? position = await _model.determinePosition();

                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(position!.latitude, position.longitude),
                        zoom: 14)));
                markers.clear();
                response = await _model.getCityHalls();
                if (response != null) {
                  for (var element in response!.results!) {
                    markers.add(Marker(
                        infoWindow: InfoWindow(title: element.name!),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                        markerId: MarkerId(element.name!),
                        position: LatLng(element.geometry!.location!.lat!,
                            element.geometry!.location!.lng!)));
                  }
                }

                markers.add(Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: LatLng(position.latitude, position.longitude)));
                Navigator.pop(context);

                setState(() {});
              },
              child: const Icon(Icons.my_location),
            ),
            const SizedBox(
              height: 5,
            ),
            FloatingActionButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Getting City halls',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
                response = await _model.getCityHalls();
                Navigator.pop(context);
                print(response!.results);
                response != null
                    ? Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                        return NearByPlacesScreen(
                          places: response!,
                        );
                      }))
                    : ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('check your internet connection'),
                          duration: Duration(seconds: 3),
                        ),
                      );
              },
              backgroundColor: mainColor,
              heroTag: "f2",
              child: const Icon(Icons.near_me),
            ),
          ],
        ),
        body: GoogleMap(
          mapToolbarEnabled: false,
          initialCameraPosition: initialCameraPosition,
          markers: markers,
          zoomControlsEnabled: false,
          buildingsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
        ),
      ),
    );
  }
}
