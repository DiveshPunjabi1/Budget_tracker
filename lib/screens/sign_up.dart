import 'package:flutter/material.dart';
import 'package:my_project/screens/dashboard.dart';
import 'package:my_project/screens/login_screen.dart';
import 'package:my_project/services/auth_service.dart';
import 'package:my_project/utils/appvalidator.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  var authServices = AuthServices();
  var isLoader = false;

  Future<void> _submitform() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "username": _userNameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phone": _phoneController.text,
        'remainingAmount': 0,
        'totalCredit': 0,
        'totalDebit': 0
      };

      await authServices.createUser(data, context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Dashboard()),
      // );
      setState(() {
        isLoader = false;
      }); // ScaffoldMessenger.of(_formkey.currentContext!).showSnackBar(
      //   const SnackBar(content: Text('Form submitted successfully')),
      // );
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    "Create new Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _userNameController,
                    style: TextStyle(color: Colors.white),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration("UserName", Icons.person),
                    validator: appValidator.validateUsername),
                //   if (value!.isEmpty) {
                //     return 'Please enter a username';
                //   }
                //   return null;
                // }),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration("Email", Icons.email),
                    validator: appValidator.validateEmail),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.white),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        _buildInputDecoration("Phone Number", Icons.call),
                    validator: appValidator.validatePhoneNumber),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration("Password", Icons.lock),
                    validator: appValidator.validatePassword),
                SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF75104)),
                        onPressed: () {
                          isLoader ? print("Loading") : _submitform();
                        },
                        // _submitform,
                        child: isLoader
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                "Create",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Color(0xFFF75104), fontSize: 20),
                    ))
                // Text(
                //   "Login",
                //   style: TextStyle(color:Color(0xFFF75104),fontSize: 25 ),
                // )
              ],
            )),
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
