import 'package:flutter/material.dart';
import 'package:my_project/screens/dashboard.dart';
import 'package:my_project/screens/sign_up.dart';
import 'package:my_project/services/auth_service.dart';
import 'package:my_project/utils/appvalidator.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var isLoader = false;
  var authServices = AuthServices();
  Future<void> _submitform() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };

      await authServices.login(data, context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
      setState(() {
        isLoader = false;
      });
    }
  }

  var appValidator = AppValidator();

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xFF000000),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Form(
  //           key: _formkey,
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 180,
  //               ),
  //               SizedBox(
  //                 width: 250,
  //                 child: Text(
  //                   "Login Account",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 28,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),

  //               TextFormField(
  //                   controller: _emailController,
  //                   keyboardType: TextInputType.emailAddress,
  //                   style: TextStyle(color: Colors.white),
  //                   autovalidateMode: AutovalidateMode.onUserInteraction,
  //                   decoration: _buildInputDecoration("Email", Icons.email),
  //                   validator: appValidator.validateEmail),
  //               SizedBox(
  //                 height: 25,
  //               ),

  //               TextFormField(
  //                   controller: _passwordController,
  //                   keyboardType: TextInputType.text,
  //                   autovalidateMode: AutovalidateMode.onUserInteraction,
  //                   decoration: _buildInputDecoration("Password", Icons.lock),
  //                   validator: appValidator.validatePassword),
  //               SizedBox(
  //                 height: 40.0,
  //               ),
  //               SizedBox(
  //                   height: 50,
  //                   width: double.infinity,
  //                   child: ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Color(0xFFF75104)),
  //                       onPressed: () {
  //                         isLoader ? print("Loading") : _submitform();
  //                       },
  //                       // _submitform,
  //                       child: isLoader
  //                           ? Center(child: CircularProgressIndicator())
  //                           : Text(
  //                               "Login",
  //                               style: TextStyle(
  //                                   color: Colors.white, fontSize: 20),
  //                             ))),
  //               SizedBox(
  //                 height: 20.0,
  //               ),
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(builder: (context) => SignUpView()),
  //                     );
  //                   },
  //                   child: Text(
  //                     "Create new Account",
  //                     style: TextStyle(color: Color(0xFFF75104), fontSize: 20),
  //                   ))
  //               // Text(
  //               //   "Login",
  //               //   style: TextStyle(color:Color(0xFFF75104),fontSize: 25 ),
  //               // )
  //             ],
  //           )),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/expense-manager-budget-planner-15.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      "Login Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration("Email", Icons.email),
                    validator: appValidator.validateEmail,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration("Password", Icons.lock),
                    validator: appValidator.validatePassword,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF75104),
                      ),
                      onPressed: () {
                        isLoader ? print("Loading") : _submitform();
                      },
                      // _submitform,
                      child: isLoader
                          ? Center(child: CircularProgressIndicator())
                          : Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpView()),
                      );
                    },
                    child: Text(
                      "Create new Account",
                      style: TextStyle(
                        color: Color(0xFFF75104),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        fillColor: Color(0xAA494A59),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x35949494))),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        filled: true,
        labelStyle: TextStyle(color: Color(0xff949494)),
        labelText: label,
        suffixIcon: Icon(
          suffixIcon,
          color: Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }
}
