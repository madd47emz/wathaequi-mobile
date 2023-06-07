import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wathaequi/view_models/createPost_vm.dart';
import 'package:wathaequi/views/res/colors.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  CreatePostViewModel _model = CreatePostViewModel();
  String _content = '';
  String _path = '';
  String _wilaya = '';
  String _commune = '';
  int currentStep = 0;
  var _imageFile;
  String _locationMessage = '';

  Future<void> _getImage(ImageSource source) async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: source);
      setState(() {
        _path = pickedFile!.path;
        _imageFile = File(pickedFile.path);
      });
    } else {
      // Handle permission not granted error here
    }
  }

  continueStep() async {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    } else {

      Navigator.pop(context,await _model.createPost(_content, _path, _locationMessage, _wilaya, _commune));
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--; //currentStep-=1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: const Text(
                'Back',
                style: TextStyle(color: darkColor, fontSize: 25),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor, // Background color
            ),
            onPressed: details.onStepContinue,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stepper(
        elevation: 0,
        controlsBuilder: controlBuilders,
        type: StepperType.horizontal,
        physics: const ScrollPhysics(),
        onStepTapped: onStepTapped,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
        currentStep: currentStep,
        steps: [
          Step(
            title: Text("Add image"),
            content: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (_imageFile != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(_imageFile),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkColor, // Background color
                        ),
                        onPressed: () => _getImage(ImageSource.camera),
                        child: Icon(
                          Icons.camera_alt,
                          size: 50,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkColor, // Background color
                        ),
                        onPressed: () => _getImage(ImageSource.gallery),
                        child: Icon(
                          Icons.folder_copy,
                          size: 50,
                        )),
                  ),
                ],
              ),
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 0 && _imageFile != ''
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: Text("Add details"),
            content: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      cursorColor: mainColor,
                      style: const TextStyle(color: darkColor, fontSize: 15),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          enabled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(15)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: darkColor.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Describe your problem',
                          hintStyle: TextStyle(
                            color: darkColor.withOpacity(0.5),
                          )),
                      maxLines: 5,
                      onChanged: (value) {
                        setState(() {
                          _content = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text("Pin location"),
            content: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _locationMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: darkColor, fontSize: 20,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Background color
                        ),
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
                                  children: [
                                    CircularProgressIndicator(color: Colors.white,),
                                    SizedBox(height: 16),
                                    Text(
                                      'Getting your address....',
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
                          LocationPermission permission =
                              await Geolocator.checkPermission();
                          if (permission == LocationPermission.denied) {
                            permission = await Geolocator.requestPermission();
                            if (permission ==
                                LocationPermission.deniedForever) {
                              setState(() {
                                _locationMessage =
                                    'Location permissions are permanently denied, we cannot request permissions.';
                              });
                            } else if (permission ==
                                LocationPermission.denied) {
                              setState(() {
                                _locationMessage =
                                    'Location permissions are denied, please enable permissions.';
                              });
                            }
                          }

                          if (permission == LocationPermission.always ||
                              permission == LocationPermission.whileInUse) {
                            try {

                              final GeolocatorPlatform geolocator =
                                  GeolocatorPlatform.instance;
                              Position position =
                                  await geolocator.getCurrentPosition(
                                      locationSettings: LocationSettings());
                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                position.latitude,
                                position.longitude,
                              );
                              Navigator.pop(context);


                              if (placemarks != null && placemarks.isNotEmpty) {
                                Placemark placemark = placemarks[0];
                                String address = placemark.street! +
                                    ", " +
                                    placemark.administrativeArea! +
                                    ", " +
                                    placemark.subAdministrativeArea!;

                                setState(() {
                                  _wilaya = placemark.administrativeArea!;
                                  _commune = placemark.subAdministrativeArea!;

                                  _locationMessage = address;
                                });
                              }
                            } catch (e) {
                              print(e);
                              setState(() {
                                _locationMessage =
                                    'Error getting location: ${e.toString()}';
                              });
                            }
                          }
                        },
                        child: Icon(
                          Icons.location_pin,
                          size: 50,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            isActive: currentStep >= 0,
            state: currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),
        ],
      ),
    ));
  }
}
