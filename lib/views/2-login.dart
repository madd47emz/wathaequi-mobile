import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wathaequi/view_models/login_vm.dart';
import 'package:wathaequi/views/3-dash.dart';
import 'package:wathaequi/views/8-forgot.dart';
import 'package:wathaequi/views/res/colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginViewModel viewModel = LoginViewModel();

  var nin;
  var password;
  final double r = 15;
  var _isObscure = true;
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
                        prefixIcon: Icon(Icons.fingerprint,color: mainColor,),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                            borderRadius: BorderRadius.circular(r)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: darkColor),
                            borderRadius: BorderRadius.circular(r)),
                        hintText: "NIN",
                        hintStyle: TextStyle(
                          color: darkColor.withOpacity(0.5),fontSize: 20
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 18,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "must login with nin";
                        }
                        if (!RegExp(r'^\d{18}$')
                            .hasMatch(value)) {
                          return ("Please enter a valid nin");
                        } else {
                          return null;
                        }
                      },
                      cursorColor: mainColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36,vertical: 10),
                    child: TextFormField(
                        onChanged: (p) => {password = p},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }

                          if (value.length < 8) {
                            return ("please enter valid password min. 8 character");
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(
                            color: darkColor
                            ,fontSize: 20),
                        textAlign: TextAlign.start,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.lock_outline,color: mainColor,)),
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,color: mainColor,),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),

                          enabled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: mainColor),
                              borderRadius:
                              BorderRadius.circular(r)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: darkColor),
                              borderRadius:
                              BorderRadius.circular(r)),
                          hintText: "Password",
                          hintStyle:  TextStyle(
                            color: darkColor.withOpacity(0.5),fontSize: 20
                          ),
                        ),
                        keyboardType:
                        TextInputType.visiblePassword,
                        // validator:
                        cursorColor: mainColor),
                  ),
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
                        String token = await viewModel.login(nin, password);
                        Navigator.pop(context);
                        if(token !="wrong email or password" && token !="error connecting") {Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Dash()));


                        } else
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      title: const Text(
                                        "Trouble",
                                        style: TextStyle(
                                            color:
                                            mainColor),
                                      ),
                                      content:  Text(
                                          token),
                                      actions: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pop(
                                                  context);
                                            },

                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:  Text(
                                                  "return",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,

                                                    fontSize: 15,
                                                      color: mainColor)),
                                            ))
                                      ],
                                    )
                            );
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
                          'Login',
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
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Center(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(

                                color: mainColor,
                                decoration: TextDecoration.underline),
                          ))),
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
                    "National Identifier Number(NIN) is provided by the Algerian government & you can find it in your id card,or given in the mayor’s office.",
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
