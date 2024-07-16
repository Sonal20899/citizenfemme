import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/API/api_list.dart';
import 'package:http/http.dart' as http;
import 'package:practice/screen/home_screen.dart';
import 'package:practice/ui/ButtonWidget.dart';
import 'package:practice/ui/alert.dart';
import 'package:practice/ui/loader.dart';

import '../ui/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errmsg = '';
  bool eye = true;
  bool chk = true;
  final RegExp _email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool _obscure = false;

  void checkBox() {
    setState(() {
      chk = !chk;
    });
  }

  //Login Api
  String message = '';

  Future<void> checkUserLogin() async {
    try {
      showLoadingDialog(context, setState);
      final response = await APIService().userLogin(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      if (response.containsKey('status') || response.containsKey('message')) {
        String status = response['status'];

        if (status == "success") {
          hideLoadingDialog(context, setState);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else if (status == "error") {
          hideLoadingDialog(context, setState);
          message = response["message"];
          showalertwarning(context, message);
        }
      }
    } catch (e) {
      hideLoadingDialog(context, setState);
      showalertwarning(context, '$e');
      throw Exception('Fail $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Container(
      height: media.height * 1,
      width: media.width * 1,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login",
            style:
                GoogleFonts.domine(fontWeight: FontWeight.w400, fontSize: 24),
          ),

          Padding(
            padding: EdgeInsets.only(
                left: media.width * 0.09, top: media.height * 0.05),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Username/ Email",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ),
          MyTextField(context, email),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.09, top: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Password",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ),
          MyTextField(context, password),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      checkBox();
                    },
                    icon: Icon(
                      chk
                          ? Icons.check_box_outline_blank_outlined
                          : Icons.check_box,
                      size: 16,
                      color: Colors.blue,
                    )),
                Text(
                  'Remember Me',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 12),
                )
              ],
            ),
          ),

          // password

          CustomButton(
            "Log In",
            context,
            () {
              checkUserLogin();
              print("Hello");
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400, fontSize: 12),
              ),
              Text(
                "Register here",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600, fontSize: 12),
              )
            ],
          )
        ],
      ),
    ));
  }
}
