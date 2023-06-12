import 'package:flutter/material.dart';
import 'package:wathaequi/views/res/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var nin;
  final double r = 15;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode:
            AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
                  child: Image.asset("assets/images/login.png"),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36,vertical: 10),
                    child: TextFormField(

                        onChanged: (name) => {nin = name},
                        style: const TextStyle(
                            color: darkColor,fontSize: 20),
                        textAlign: TextAlign.start,
                        enabled: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.sms,color: mainColor,),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(r)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkColor),
                              borderRadius: BorderRadius.circular(r)),
                          hintText: "Sent degits",
                          hintStyle: TextStyle(
                              color: darkColor.withOpacity(0.5),fontSize: 20
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 7,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "must login with nin";
                          }
                          if (!RegExp(r'^\d{7}$')
                              .hasMatch(value)) {
                            return ("Please enter a valid nin");
                          } else {
                            return null;
                          }
                        },
                        cursorColor: mainColor)),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(
                                color: Colors.white),
                          ),
                        );
                      //   String response = await viewModel.login(nin, password);
                      //   Navigator.pop(context);
                      //   if(token !="wrong email or password" && token !="error connecting") {Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               Dash()));
                      //
                      //
                      //   } else
                      //     showDialog(
                      //         context: context,
                      //         builder: (context) =>
                      //             AlertDialog(
                      //               title: const Text(
                      //                 "Trouble",
                      //                 style: TextStyle(
                      //                     color:
                      //                     mainColor),
                      //               ),
                      //               content:  Text(
                      //                   token),
                      //               actions: [
                      //                 GestureDetector(
                      //                     onTap: () {
                      //                       Navigator.pop(
                      //                           context);
                      //                     },
                      //
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child:  Text(
                      //                           "return",
                      //                           style: TextStyle(
                      //                               fontWeight: FontWeight.bold,
                      //
                      //                               fontSize: 15,
                      //                               color: mainColor)),
                      //                     ))
                      //               ],
                      //             )
                      //     );
                      }
                    },

                    child: Container(
                      height:
                      MediaQuery.of(context).size.height *
                          0.09,
                      width: MediaQuery.of(context).size.width *
                          0.4,
                      decoration: BoxDecoration(
                          boxShadow:  [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.25),
                            )
                          ],
                          color: mainColor,
                          borderRadius:
                          BorderRadius.circular(MediaQuery.of(context).size.width *
                              0.4*0.5)),
                      child: const Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                            fontSize: 30,

                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Container(
                    color: darkColor,
                    height: 2,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                  child: Text(
                    "Check your Phone for incoming sms from Twilio",
                    style: TextStyle(color: darkColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
