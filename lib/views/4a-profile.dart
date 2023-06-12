import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wathaequi/models/Citizen.dart';
import 'package:wathaequi/view_models/profile_vm.dart';
import 'package:wathaequi/views/2-login.dart';

import 'res/colors.dart';

class Profile extends StatelessWidget {


  final Citizen citizen;
  final String phone;
  const Profile({
    super.key, required this.citizen, required this.phone,
  });

  @override
  Widget build(BuildContext context) {

    final _address = TextEditingController();
    _address.text="Wilaya de ${citizen.wilaya}, Dayra de ${citizen.dayra}, Commune de ${citizen.commune}.";
    final _email = TextEditingController();
    final _phone = TextEditingController();
    _phone.text=phone;

    final _password = TextEditingController();
    _password.text=citizen.password;




    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                          color: darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    IconButton(
                        onPressed: () async{

                          var response = await showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Logout'),
                                  content: const Text(
                                      'Do you want to logout?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel',
                                          style:
                                          TextStyle(color: Colors.black)),
                                    ),
                                    TextButton(
                                      onPressed: () =>

                                          Navigator.pop(context, 'OK'),
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ]));
                          if (response == "OK") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Login()));
                          }


                        },
                        icon: Icon(
                          Icons.logout,
                          size: 30,
                          color: mainColor,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 154,
                    width: 129,
                    color: accentColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(citizen.fullNameLat!,style: const TextStyle(fontSize: 20,color: darkColor,fontWeight: FontWeight.bold),),
                        Text(citizen.nin,style: const TextStyle(fontSize: 15,color: mainColor)),
                        Text(citizen.birthdate!,style: const TextStyle(fontSize: 15,color: darkColor)),
                        Text(citizen.gender!,style: const TextStyle(fontSize: 15,color: mainColor)),

                      ],
                    ),
                  )

                ],
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextField(
                  controller: _address,
                  readOnly: true,
                  cursorColor: mainColor,
                  style: const TextStyle(
                      color: darkColor,
                      fontSize: 15),
                  textAlign: TextAlign.left,

                  decoration: InputDecoration(
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: mainColor),
                          borderRadius:
                          BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: darkColor.withOpacity(0.5)),
                          borderRadius:
                          BorderRadius.circular(15)),


                  ),
                  maxLines: 3,

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextField(

                  controller: _email,
                  readOnly: true,
                  cursorColor: mainColor,
                  style: const TextStyle(
                      color: darkColor,
                      fontSize: 15),
                  textAlign: TextAlign.left,

                  decoration: InputDecoration(

                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: mainColor),
                          borderRadius:
                          BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: darkColor.withOpacity(0.5)),
                          borderRadius:
                          BorderRadius.circular(15)),

                      hintText: 'set an Email',
                      hintStyle:  TextStyle(
                        color: darkColor.withOpacity(0.5),)
                  ),


                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextField(
                  controller: _phone,
                  readOnly: true,
                  cursorColor: mainColor,
                  style: const TextStyle(
                      color: darkColor,
                      fontSize: 15),
                  textAlign: TextAlign.left,

                  decoration: InputDecoration(
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: mainColor),
                          borderRadius:
                          BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: darkColor.withOpacity(0.5)),
                          borderRadius:
                          BorderRadius.circular(15)),

                      hintText: 'set an Phone',
                      hintStyle:  TextStyle(
                        color: darkColor.withOpacity(0.5),)
                  ),


                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextField(

                  controller: _password,
                  readOnly: true,
                  cursorColor: mainColor,
                  style: const TextStyle(
                      color: darkColor,
                      fontSize: 15),
                  textAlign: TextAlign.left,

                  decoration: InputDecoration(

                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: mainColor),
                          borderRadius:
                          BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: darkColor.withOpacity(0.5)),
                          borderRadius:
                          BorderRadius.circular(15)),

                      hintText: 'set an Phone',
                      hintStyle:  TextStyle(
                        color: darkColor.withOpacity(0.5),)
                  ),


                ),
              ),






            ],
          ),
        ),
      ),
    );
  }
}


