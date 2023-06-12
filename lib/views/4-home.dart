import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wathaequi/models/Citizen.dart';
import 'package:wathaequi/view_models/document_vm.dart';
import 'package:wathaequi/view_models/profile_vm.dart';
import 'package:wathaequi/views/4b-documents.dart';
import 'package:wathaequi/views/res/colors.dart';
import 'package:wathaequi/views/util/documentCard.dart';
import 'package:wathaequi/views/4a-profile.dart';

import '../models/Paper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final DocViewModel _docViewModel = DocViewModel();
  List<Paper> papers = [];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: mainColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: StreamBuilder<Citizen>(
                      stream: _profileViewModel.getProfile(),
                      builder: ((BuildContext context,
                          AsyncSnapshot<Citizen> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else if (!snapshot.hasData) {
                          return Center(
                            child: Text('No profile found',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),
                          );
                        } else {
                          Citizen citizen = snapshot.data!;

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(36),
                                child: Text(
                                  "Welcome Back!!!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 60,
                                  child: Text(
                                    citizen.fullNameLat!
                                        .split(' ')
                                        .map((word) => word[0].toUpperCase())
                                        .join(''),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 60,
                                        color: mainColor),
                                  ),
                                ),
                              )),
                              GestureDetector(
                                onTap: () async{
                                  String phone = "";
                                  final SharedPreferences cashe = await SharedPreferences.getInstance();
                                  final String token = cashe.getString("token")!;

                                  try{
                                    Dio dio = Dio();
                                    dio.options.headers['Authorization'] = 'Bearer $token';
                                    Response response = await dio.get("$baseUrl/sms/api/v1/checkUser/${citizen.nin}");
                                    if(response.statusCode==200){
                                      phone= response.data!;
                                    }

                                  }catch(e){
                                    print(e);
                                  }

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Profile(citizen: citizen,phone: phone,)));
                                },
                                child: Center(
                                  child: Text(
                                    citizen.fullNameLat!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  citizen.nin,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        }
                      })),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Documents",
                    style: TextStyle(
                        color: darkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (papers.isNotEmpty)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Documents(
                                      paper: papers,
                                      docViewModel: _docViewModel,
                                    )));
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(
                          color: mainColor,
                          decoration: TextDecoration.underline,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder<List<Paper>>(
                stream: _docViewModel.getPapers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: darkColor, fontSize: 20),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text('Loading...',
                          style: TextStyle(color: darkColor, fontSize: 20)),
                    );
                  }
                  if (snapshot.hasData) {
                    papers = snapshot.data!;

                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return DocCard(
                            paper: papers[index],
                            docViewModel: _docViewModel,
                          );
                        },
                        itemCount: papers.length,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('No documents yet',
                          style: TextStyle(color: darkColor, fontSize: 20)),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

class OvalBottomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = 60;

    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - radius);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
